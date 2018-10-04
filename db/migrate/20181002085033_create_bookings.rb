class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :room_type
      t.date :start_date
      t.date :last_date
      t.integer :user_id
      t.integer :room_id

      t.timestamps null: false
    end
    add_index :bookings, :room_type
    add_index :bookings, :room_id
  end
end
