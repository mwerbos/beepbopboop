class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.references :activity
      t.references :event

      t.timestamps
    end
    add_index :preferences, :user_id
    add_index :preferences, :activity_id
    add_index :preferences, :event_id
  end
end
