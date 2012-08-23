class WeatherRecord < ActiveRecord::Base
  attr_accessible :chance_of_rain, :high, :low, :recorded_at, :user_id, :weather_date, :weather_service_id
end
