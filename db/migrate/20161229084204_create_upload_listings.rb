class CreateUploadListings < ActiveRecord::Migration
  def change
    create_table :upload_listings do |t|
      t.string :image
      t.references :listing, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
