class Property < ApplicationRecord
  attr_accessor :image_cache
  mount_uploaders :images, PropertyImageUploader

  enum deal: [ :sale, :rent ]

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.property.#{field}.#{value}"), value]
    end
  end

end
