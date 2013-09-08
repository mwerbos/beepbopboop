class AddUsersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :users, :text
  end
end
