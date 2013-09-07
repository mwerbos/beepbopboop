class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :activtiy

      t.timestamps
    end
    add_index :events, :activtiy_id
  end
end
