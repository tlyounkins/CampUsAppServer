class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :body
      t.integer :unread

      t.timestamps null: false
    end
  end
end
