class NOAA
  include HTTParty

  base_uri 'http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/stations'

  def self.configure(token)
    @@token = token
  end

  def self.get_weather_for_date(station_id, date)
    begin
      options = {:year => date.year, :startday => date.day, :endday => date.day, :month => date.month, :token => @@token}
      max = self.get "/GHCND:#{station_id}/datatypes/TMAX/data", :query => options
      max_f = self.c_to_f(max["dataCollection"]["data"]["value"]/10.0)
      sleep 1 # throttled :(
      min = self.get "/GHCND:#{station_id}/datatypes/TMIN/data", :query => options
      min_f = self.c_to_f(min["dataCollection"]["data"]["value"]/10.0)
      # recorded at is really fetched at
      {:low => min_f, :high => max_f, :recorded_at => Time.current, :weather_date => Date.parse(max["dataCollection"]["data"]["date"])}
    rescue Exception => ex
      nil
    end
  end

  def self.get_date_of_most_recent_data(station_id)
    data = self.get_station_data(station_id)
    Date.parse(data["stationCollection"]["station"][0]["maxDate"])
  end

  def self.get_station_data(station_id)
    options = {:token => @@token}
    self.get "/GHCND:#{station_id}", :query => options
  end

  def self.pull_latest_data(cities)
    noaa = WeatherService.find_by_short_name("NOAA")
    cities.each do |city|
      records = city.weather_records.where(:weather_service_id => noaa.id).order("weather_date ASC")
      if records.any?
        start_date = records.last.weather_date + 1.day
      else
        start_date = Date.today - 30.days # only look back 30 days
      end
      end_date = self.get_date_of_most_recent_data(city.station_id)
      sleep 1
      while start_date <= end_date
        weather = self.get_weather_for_date(city.station_id, start_date)
        if weather.present?
          WeatherRecord.create(weather.merge(:city_id => city.id, :weather_service_id => noaa.id))
        end
        start_date += 1.day
        sleep 1
      end
    end
  end

  def self.seed_fake_data_for_service(service, cities, years_back)
    noaa = WeatherService.find_by_short_name("NOAA")
    cities.each do |city|
      Time.zone = city.timezone
      today = Time.current.to_date
      start_date = today - years_back.years - 30.days # only look back 30 days
      end_date = today - years_back.years # only look back 30 days
      while start_date <= end_date
        weather = self.get_weather_for_date(city.station_id, start_date)
        if weather.present?
          weather[:weather_date] = weather[:weather_date] + years_back.years
          WeatherRecord.create(weather.merge(:city_id => city.id, :weather_service_id => service.id))
        end
        start_date += 1.day
        sleep 1
      end
    end
  end

  private
  def self.c_to_f(val)
    val * 9 / 5 + 32
  end

end
