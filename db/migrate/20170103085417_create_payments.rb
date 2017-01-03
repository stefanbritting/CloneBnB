class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :reservation, index: true, foreign_key: true
      t.float :amount
      t.date :executed_at
      t.string :braintree_transaction_id
      t.string :cardholder_name
      t.string :customer_location
      t.integer :braintree_customer_id
      t.timestamps null: false
    end
  end
end
