class AddMaxTimeToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :max_time, :float, default: 3600
  end
end
