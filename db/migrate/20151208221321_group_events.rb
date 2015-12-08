class GroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string :name
      t.integer :group_id
      t.datetime :startdate
      t.datetime :enddate
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
