class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string user_name
      t.string :first_name
      t.string last_name
      t.string :password

      t.timestamps null: false
    end
  end
end
