class AddCurrentAtToCurrentForecast < ActiveRecord::Migration
  def change
    add_column :current_forecasts, :current_at, :datetime
  end
end
