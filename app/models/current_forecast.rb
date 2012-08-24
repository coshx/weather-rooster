class CurrentForecast < ActiveRecord::Base
  attr_accessible :city_id, :current_temp, :day_0_high, :day_0_low, :day_0_string, :day_1_high, :day_1_low, :day_1_string, :day_2_high, :day_2_low, :day_2_string, :day_3_high, :day_3_low, :day_3_string, :day_4_high, :day_4_low, :day_4_string, :day_5_high, :day_5_low, :day_5_string, :weather_service_id, :current_at
end
