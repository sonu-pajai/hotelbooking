class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_no
      t.integer :price
      t.integer :room_type

      t.timestamps null: false
    end
  end
end
