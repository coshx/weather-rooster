class CreateCurrentForecasts < ActiveRecord::Migration
  def change
    create_table :current_forecasts do |t|
      t.integer :weather_service_id
      t.integer :city_id
      t.integer :current_temp
      t.integer :day_0_high
      t.integer :day_0_low
      t.string :day_0_string
      t.integer :day_1_high
      t.integer :day_1_low
      t.string :day_1_string
      t.integer :day_2_high
      t.integer :day_2_low
      t.string :day_2_string
      t.integer :day_3_high
      t.integer :day_3_low
      t.string :day_3_string
      t.integer :day_4_high
      t.integer :day_4_low
      t.string :day_4_string
      t.integer :day_5_high
      t.integer :day_5_low
      t.string :day_5_string

      t.timestamps
    end
  end
end
