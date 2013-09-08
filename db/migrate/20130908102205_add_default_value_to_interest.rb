class AddDefaultValueToInterest < ActiveRecord::Migration
  def up
      change_column :preferences, :interest, :integer, :default => 1
  end

  def down
      change_column :preferences, :interest, :integer, :default => nil
  end
end
