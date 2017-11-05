class CustomerPropertiesController < ApplicationController
  before_action :authenticate_admin!, only: :index

  def index
    customer_properties = CustomerProperty.all
    @customer_properties = customer_properties.page(params[:page])
    @unread_count = CustomerProperty.unread_count

    render "index"

    @customer_properties.each do |item|
      item.update read_at: Time.now if item.read_at.nil?
    end
  end

  def new
    @customer_property = CustomerProperty.new
  end

  def create
    @customer_property = CustomerProperty.new customer_property_params

    if @customer_property.save
      redirect_to root_path, flash: { notice: "Obrigado, avaliaremos seu imóvel e entraremos em contato." }
    else
      render "new"
    end
  end

  def destroy
    customer_property = CustomerProperty.find(params[:id]) if params[:id]

    if customer_property.destroy
      redirect_to customer_properties_path,
      flash: { notice: "Excluído com sucessso!" }
    else
      redirect_to customer_properties_path,
      flash: { alert: "Ocorreu um problema com a exclusão" }
    end
  end

  private

  def customer_property_params
    params.require(:customer_property).permit CUSTOMER_PROPERTY_PARAMS
  end
end
