class Property < ApplicationRecord
  monetize :value_cents
  has_one :gallery

  enum deal: [ :sale, :rent ]

  validates :title, presence: true
	# validates :district, presence: true
	# validates :address, presence: true

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.property.#{field}.#{value}"), value]
    end
  end

  def self.query_for_listing params
    all
  end
end
