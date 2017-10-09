class Property < ApplicationRecord
  mount_uploaders :images, ImageUploader

  enum deal: [ :sale, :rent ]

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.property.#{field}.#{value}"), value]
    end
  end

end
