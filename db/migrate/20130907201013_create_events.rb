class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.references :activity

      t.timestamps
    end
    add_index :events, :activity_id
  end
  def down
    drop_table :events
  end
end
