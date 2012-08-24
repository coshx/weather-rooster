class CreateWeatherStatuses < ActiveRecord::Migration
  def change
    create_table :weather_statuses do |t|
      t.string :api_name
      t.string :name

      t.timestamps
    end
  end
end
