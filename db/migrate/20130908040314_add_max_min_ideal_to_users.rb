class AddMaxMinIdealToUsers < ActiveRecord::Migration
  def change
    add_column :users, :max, :integer
    add_column :users, :min, :integer
    add_column :users, :ideal, :integer
  end
end
