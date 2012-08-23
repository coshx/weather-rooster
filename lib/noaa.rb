class NOAA
  include HTTParty

  base_uri 'http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/stations'

  def self.configure(token)
    @@token = token
  end

  def self.get_weather_for_date(station_id, date)
    options = {:year => date.year, :startday => date.day, :endday => date.day, :month => date.month, :token => @@token}
    max = self.get "/GHCND:#{station_id}/datatypes/TMAX/data", :query => options
    max_f = self.c_to_f(max["dataCollection"]["data"]["value"]/10.0)
    sleep 1 # throttled :(
    min = self.get "/GHCND:#{station_id}/datatypes/TMIN/data", :query => options
    min_f = self.c_to_f(min["dataCollection"]["data"]["value"]/10.0)
    {:low => min_f, :high => max_f, :fetched_at => Time.current, :date => Date.parse(max["dataCollection"]["data"]["date"])}
  end

  def self.get_date_of_most_recent_data(station_id)
    data = self.get_station_data(station_id)
    Date.parse(data["stationCollection"]["station"][0]["maxDate"])
  end

  def self.get_station_data(station_id)
    options = {:token => @@token}
    self.get "/GHCND:#{station_id}", :query => options
  end

  private
  def self.c_to_f(val)
    val * 9 / 5 + 32
  end

end
