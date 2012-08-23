class AddPostalCodeToCity < ActiveRecord::Migration
  def change
    add_column :cities, :postal_code, :string
  end
end
