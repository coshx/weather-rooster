class CreateWeatherServices < ActiveRecord::Migration
  def change
    create_table :weather_services do |t|
      t.string :full_name
      t.string :short_name
      t.string :homepage_url
      t.string :zipcode_url_template
      t.boolean :active

      t.timestamps
    end
  end
end
