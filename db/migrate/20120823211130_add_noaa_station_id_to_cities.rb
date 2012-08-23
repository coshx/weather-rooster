class AddNoaaStationIdToCities < ActiveRecord::Migration
  def change
    add_column :cities, :station_id, :string
  end
end
