class AddRegionCodeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :region_code, :string
  end
end
