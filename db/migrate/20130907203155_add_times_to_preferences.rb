class AddTimesToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :times, :text
  end
end
