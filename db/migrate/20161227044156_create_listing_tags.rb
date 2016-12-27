class CreateListingTags < ActiveRecord::Migration
  def change
    create_table :listing_tags do |t|
      t.references :listing, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
