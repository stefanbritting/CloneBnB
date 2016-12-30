class UploadListing < ActiveRecord::Base
  belongs_to :listing
  mount_uploader :image, ImageUploader
  ################################
      # mehtods
end
