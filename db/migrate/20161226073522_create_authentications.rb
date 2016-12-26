class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :token
      t.string :provider
      t.references :uesr_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
