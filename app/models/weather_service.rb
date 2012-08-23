class WeatherService < ActiveRecord::Base
  attr_accessible :active, :full_name, :homepage_url, :short_name, :zipcode_url_template

  has_many :weather_records

  def get_tomorrows_weather(zipcode)
    if short_name == "Google"
      Barometer.config = { 1 => [:google] }
    elsif short_name == "Wunderground"
      Barometer.config = { 1 => [:wunderground] }
    else
      return "ERROR, not a recognized service: #{short_name}"
    end
    barometer = Barometer.new(zipcode.to_s)
    weather = barometer.measure
    {:low => weather.forecast[1].low.to_i, :high => weather.forecast[1].high.to_i, :date => weather.forecast[1].date, :fetched_at => Time.current}

  end
end
