class ChangeSenderColumnName < ActiveRecord::Migration
  def change
    rename_column :private_messages, :sender_id, :user_id
  end
end
