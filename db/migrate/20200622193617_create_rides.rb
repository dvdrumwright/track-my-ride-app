class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :title
      t.text :description
      t.integer :ride_distance
      t.integer :ride_date
      t.integer :cyclist_id
      t.integer :ride_id
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
      t.timestamps
    end
  end
end
