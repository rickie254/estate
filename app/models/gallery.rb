class Gallery < ApplicationRecord
  mount_uploader :images, GalleryImageUploader
end
