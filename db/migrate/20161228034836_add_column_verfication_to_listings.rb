class AddColumnVerficationToListings < ActiveRecord::Migration
  def change
    add_column :listings, :verification, :boolean
  end
end
