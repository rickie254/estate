class Property < ApplicationRecord
  attr_accessor :image_cache
  mount_uploaders :images, PropertyImageUploader

  monetize :value_cents

  enum deal: [ :sale, :rent ]

  validates :title, presence: true
	validates :district, presence: true
	validates :address, presence: true

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.property.#{field}.#{value}"), value]
    end
  end

end
