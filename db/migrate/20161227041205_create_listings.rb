class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description
      t.string :country
      t.string :city
      t.string :zip_code
      t.text :street_address
      t.integer :price_per_night, null: false
      t.integer :fees
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
