class AddMaxMinIdealToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :max, :integer
    add_column :activities, :min, :integer
    add_column :activities, :ideal, :integer
  end
end
