class CustomerProperty < ApplicationRecord
  enum kind: [ :house, :apartment, :comercial, :terrain ]
  enum deal: [ :rent, :sale ]

  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :phone, length: { minimum: 14, maximum: 15 }

  validates :address, :email, :phone, :name, :kind, :deal, presence: true

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.customer_property.#{field}.#{value}"), value]
    end
  end
end
