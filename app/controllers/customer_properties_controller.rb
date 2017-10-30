class CustomerPropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]
  include ApplicationHelper

  def new
    @customer_property = CustomerProperty.new
  end

  def index
    @customer_properties = CustomerProperty.all
  end

  def create
    @customer_property = CustomerProperty.new customer_property_params
    # unmask_fields

    if @customer_property.save
      redirect_to root_path, flash: { notice: "Obrigado, avaliaremos seu imóvel e entraremos em contato." }
    else
      render "new"
    end
  end

  private

  def customer_property_params
    params.require(:customer_property).permit CUSTOMER_PROPERTY_PARAMS
  end

  def unmask_fields
    global_area = property_params[:global_area]
    private_area = property_params[:private_area]

    @property.attributes = property_params
    @property.global_area = global_area.comma_to_delimiter if global_area
    @property.private_area = private_area.comma_to_delimiter if private_area
  end
end
