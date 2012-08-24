require 'gsl'

class WeatherService < ActiveRecord::Base
  attr_accessible :active, :full_name, :homepage_url, :short_name, :zipcode_url_template

  has_many :weather_records
  has_many :current_forecasts

  def get_tomorrows_weather(city)
    config_barometer
    barometer = Barometer.new(city.postal_code)
    weather = barometer.measure
    {:low => weather.forecast[1].low.to_i, :high => weather.forecast[1].high.to_i, :date => weather.forecast[1].date, :fetched_at => Time.current}

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
    noaa = WeatherService.find_by_short_name("NOAA")
    Time.zone = city.timezone
    # look 30 days back
    start_date = Time.current.to_date - 30.days
    end_date = Time.current.to_date
    noaa_data = WeatherRecord.where(:weather_service_id => noaa.id, :city_id => city.id)
    noaa_data = noaa_data.where(["weather_date >= ?", start_date])
    noaa_data = noaa_data.where(["weather_date <= ?", end_date])
    noaa_data = noaa_data.order("weather_date asc")
    our_data = WeatherRecord.where(:weather_service_id => self.id, :city_id => city.id)
    our_data = our_data.where(["weather_date >= ?", start_date])
    our_data = our_data.where(["weather_date <= ?", end_date])
    our_data = our_data.order("weather_date asc")
    forecast_lows = []
    forecast_highs = []
    actual_lows = []
    actual_highs = []
    noaa_data.each do |record|
      our_record = our_data.find {|r| r.weather_date == record.weather_date}
      if our_record.present?
        forecast_lows << record.low
        actual_lows << our_record.low
        forecast_highs << record.high
        actual_highs << our_record.high
      end
    end
    correlation_lows = self.class.gsl_pearson(forecast_lows, actual_lows)
    correlation_highs = self.class.gsl_pearson(forecast_highs, actual_highs)
    ((correlation_lows.abs + correlation_highs.abs * 100)/ 2).to_i
  end

  def recent_mse_score(city)
    noaa = WeatherService.find_by_short_name("NOAA")
    Time.zone = city.timezone
    # look 30 days back
    start_date = Time.current.to_date - 30.days
    end_date = Time.current.to_date
    noaa_data = WeatherRecord.where(:weather_service_id => noaa.id, :city_id => city.id)
    noaa_data = noaa_data.where(["weather_date >= ?", start_date])
    noaa_data = noaa_data.where(["weather_date <= ?", end_date])
    noaa_data = noaa_data.order("weather_date asc")
    our_data = WeatherRecord.where(:weather_service_id => self.id, :city_id => city.id)
    our_data = our_data.where(["weather_date >= ?", start_date])
    our_data = our_data.where(["weather_date <= ?", end_date])
    our_data = our_data.order("weather_date asc")
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
end
