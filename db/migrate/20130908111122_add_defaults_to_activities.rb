class AddDefaultsToActivities < ActiveRecord::Migration
  def up
      change_column :activities, :max, :integer, :default => 10000
      change_column :activities, :min, :integer, :default => 0
      change_column :activities, :ideal, :integer, :default => 10
  end
  def down
      change_column :activities, :max, :integer, :default => nil
      change_column :activities, :min, :integer, :default => nil
      change_column :activities, :ideal, :integer, :default => nil
  end
end
