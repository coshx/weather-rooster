class WeatherRecord < ActiveRecord::Base
  # recorded at is really fetched at
  attr_accessible :chance_of_rain, :high, :low, :recorded_at, :user_id, :weather_date, :weather_service_id, :city_id

  belongs_to :city
  belongs_to :weather_service
end
