class CreateWeatherRecords < ActiveRecord::Migration
  def change
    create_table :weather_records do |t|
      t.integer :high
      t.integer :low
      t.date :weather_date
      t.integer :chance_of_rain
      t.datetime :recorded_at
      t.integer :weather_service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
