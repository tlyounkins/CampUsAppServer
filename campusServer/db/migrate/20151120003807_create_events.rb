class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :startdate
      t.datetime :enddate
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
