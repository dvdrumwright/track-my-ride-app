class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :user_id
      t.integer :distance
      t.integer :time
      t.string :mood
      t.timestamps
    end
  end
end
