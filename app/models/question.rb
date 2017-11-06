class Question
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :message, :property_id

  def initialize params=nil
    @email = params[:email] if params
    @message = params[:message] if params
    @property_id = params[:property_id] if params
  end

  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, :message, :property_id, presence: true

  def persisted?
    false
  end
end
