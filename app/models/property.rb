class Property < ApplicationRecord
  acts_as_paranoid
  paginates_per 10

  monetize :value_cents
  has_one :gallery
  has_one :extra_list

  enum deal: [ :sale, :rent ]
  enum position: [ :front, :back ]

  validates :title, presence: true
  validates :address, presence: true
	validates :district, presence: true

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.property.#{field}.#{value}"), value]
    end
  end

  def self.query_for_listing filter
    if filter
      if filter[:is_enterprise]
        where(is_enterprise: true)
      else
        all
      end
    end
  end
end
