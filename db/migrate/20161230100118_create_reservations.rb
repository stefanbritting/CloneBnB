class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :from
      t.date :to

      t.timestamps null: false
    end
  end
end
