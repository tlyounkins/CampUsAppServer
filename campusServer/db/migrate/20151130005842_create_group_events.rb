class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string :name
      t.string :description
      t.integer :group_id
      t.date :date
      t.time :start
      t.time :end

      t.timestamps null: false
    end
  end
end
