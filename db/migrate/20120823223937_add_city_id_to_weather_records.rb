class AddCityIdToWeatherRecords < ActiveRecord::Migration
  def change
    add_column :weather_records, :city_id, :integer
  end
end
