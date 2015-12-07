class CreateGroupMicroposts < ActiveRecord::Migration
  def change
    create_table :group_microposts do |t|
      t.string :content
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
