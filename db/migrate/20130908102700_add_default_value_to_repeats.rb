class AddDefaultValueToRepeats < ActiveRecord::Migration
  def up
      change_column :preferences, :repeats , :integer, :default => 1
  end

  def down
      change_column :preferences, :repeats , :integer, :default => nil
  end
end
