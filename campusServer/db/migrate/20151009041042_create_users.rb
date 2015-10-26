class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.string :bio
      t.string :major
      t.string :hometown
      t.integer :age
      t.string :gender
      t.string :inbox


      t.timestamps null: false
    end
  end
end
