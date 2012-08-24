require 'gsl'

class WeatherService < ActiveRecord::Base
  attr_accessible :active, :full_name, :homepage_url, :short_name, :zipcode_url_template

  has_many :weather_records
  has_many :current_forecasts

  def pull_tomorrows_weather(city)
    config_barometer
    barometer = Barometer.new(city.postal_code)
    weather = barometer.measure
    p = {:low => weather.forecast[1].low.to_i, :high => weather.forecast[1].high.to_i, :recorded_at => Time.current}
    key_params = {:city_id => city.id, :weather_service_id => self.id,
                  :weather_date => weather.forecast[1].date}
    records = WeatherRecord.where(key_params)
    if records.any?
      # noop
    else
      WeatherRecord.create(key_params.merge(p))
    end
  end

  def pull_latest_forecast(city)
    config_barometer
    barometer = Barometer.new(city.postal_code)
    key_params = {:city_id => city.id, :weather_service_id => self.id}
    p = {}
    weather = barometer.measure
    if weather.current.current_at.present?
      p[:current_at] = weather.current.current_at.to_t
    else
      p[:current_at] = Time.current
    end
    p[:current_temp] = weather.current.temperature.to_i
    weather.forecast.slice(0..5).each_with_index do |f, i|
      p["day_#{i}_high"] = f.high.to_i
      p["day_#{i}_low"] = f.low.to_i
      if f.icon.present?
        p["day_#{i}_string"] = f.icon
      else
        p["day_#{i}_string"] = f.condition
      end
    end
    records = CurrentForecast.where(key_params)
    if records.any?
      record = records.first
      record.update_attributes(p)
    else
      record = CurrentForecast.create(key_params.merge(p))
    end
  end

  def recent_cc_score(city)
    data = full_comparison_data(city)
    correlation_lows = self.class.gsl_pearson(data[:forecast_lows].map {|a| a[1]}, data[:actual_lows].map {|a| a[1]})
    correlation_highs = self.class.gsl_pearson(data[:forecast_highs].map {|a| a[1]}, data[:actual_highs].map {|a| a[1]})
    ((correlation_lows.abs + correlation_highs.abs * 100)/ 2).to_i
  end

  def full_comparison_data(city)
    Time.zone = city.timezone
    noaa_data = recent_noaa_data(city)
    our_data = recent_our_data(city)
    data = {}
    data[:forecast_lows] = []
    data[:forecast_highs] = []
    data[:actual_lows] = []
    data[:actual_highs] = []
    noaa_data.each do |record|
      our_record = our_data.find {|r| r.weather_date == record.weather_date}
      if our_record.present?
        data[:forecast_lows] << [record.weather_date, our_record.low]
        data[:actual_lows] << [record.weather_date, record.low]
        data[:forecast_highs] << [record.weather_date, our_record.high]
        data[:actual_highs] << [record.weather_date, record.high]
      end
    end
    data
  end

  def delta_comparison_data(city)
    Time.zone = city.timezone
    noaa_data = recent_noaa_data(city)
    our_data = recent_our_data(city)
    data = []
    noaa_data.each do |record|
      our_record = our_data.find {|r| r.weather_date == record.weather_date}
      if our_record.present?
        delta_low = (our_record.low - record.low).abs
        delta_high = (our_record.high - record.high).abs
        data << [record.weather_date, (delta_low+delta_high)/2.0]
      end
    end
    data
  end

  def recent_mse_score(city)
    Time.zone = city.timezone
    # look 30 days back
    noaa_data = recent_noaa_data(city)
    our_data = recent_our_data(city)
    observed_lows = []
    observed_highs = []
    actual_lows = []
    actual_highs = []
    noaa_data.each do |record|
      our_record = our_data.find {|r| r.weather_date == record.weather_date}
      if our_record.present?
        observed_lows << record.low
        actual_lows << our_record.low
        observed_highs << record.high
        actual_highs << our_record.high
      end
    end
    n = observed_lows.count
    sum_lows = sum_highs = 0.0
    n.times do |i|
      sum_lows += (observed_lows[i] - actual_lows[i]).abs
      sum_highs += (observed_highs[i] - actual_highs[i]).abs
    end
    error_lows = (1.0/n)*sum_lows
    error_highs = (1.0/n)*sum_highs
    # NOTE need to address averaging these and projecting them on 0-100
  end

  def self.pull_all_tomorrow(timezone)
    WeatherService.where(:active => true).shuffle.each do |service|
      cities = City.find_all_by_timezone(timezone).map do |c|
        {:city => c, :tries => 0}
      end
      while cities.any?
        cities.each do |city|
          begin
            service.pull_tomorrows_weather(city[:city])
            cities -= [city]
          rescue
            city[:tries] += 1
            cities -= [city] if city[:tries] > 10
          end
          sleep 1
        end
      end
    end
  end

  def url_for_city(city)
    zipcode_url_template.gsub(/ZIPCODE_HERE/, city.postal_code)
  end

  private
  def self.gsl_pearson(x,y)
    # thank you http://blog.chrislowis.co.uk/2008/11/24/ruby-gsl-pearson.html
    GSL::Stats::correlation(
      GSL::Vector.alloc(x),GSL::Vector.alloc(y)
    )
  end

  def config_barometer
    if short_name == "Google"
      Barometer.config = { 1 => [:google] }
    elsif short_name == "Wunderground"
      Barometer.config = { 1 => [:wunderground] }
    else
      return "ERROR, not a recognized service: #{short_name}"
    end
  end

  def recent_noaa_data(city)
    noaa = WeatherService.find_by_short_name("NOAA")
    start_date = Time.current.to_date - 30.days
    end_date = Time.current.to_date
    @noaa_data ||= {}
    @noaa_data[city.name.to_sym] ||= WeatherRecord.where(:weather_service_id => noaa.id, :city_id => city.id).where(["weather_date >= ?", start_date]).where(["weather_date <= ?", end_date]).order("weather_date asc")
  end

  def recent_our_data(city)
    start_date = Time.current.to_date - 30.days
    end_date = Time.current.to_date
    @our_data ||= {}
    @our_data[city.name.to_sym] ||= WeatherRecord.where(:weather_service_id => self.id, :city_id => city.id).where(["weather_date >= ?", start_date]).where(["weather_date <= ?", end_date]).order("weather_date asc")
  end

end
