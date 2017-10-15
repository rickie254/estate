class Gallery < ApplicationRecord
  # belongs_to :property
  mount_uploaders :images, GalleryImageUploader
end
