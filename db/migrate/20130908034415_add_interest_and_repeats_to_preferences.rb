class AddInterestAndRepeatsToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :interest, :float
    add_column :preferences, :repeats, :integer
  end
end
