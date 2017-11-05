class CustomerProperty < ApplicationRecord
  paginates_per 10

  enum kind: [ :house, :apartment, :comercial, :terrain ]
  enum deal: [ :rent, :sale ]

  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :phone, length: { minimum: 14, maximum: 15 }

  validates :address, :email, :phone, :name, :kind, :deal, presence: true

  def self.default_scope
    order(created_at: :desc)
  end

  def self.unread_count
    where(read_at: nil).count
  end

  def self.attributes_for_select field
    eval(field).map do |value, _|
      [I18n.t("activerecord.attributes.customer_property.#{field}.#{value}"), value]
    end
  end
end
