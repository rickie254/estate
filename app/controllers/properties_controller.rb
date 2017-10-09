class PropertiesController < ApplicationController
  def index
  end
  def show
  end
  def new
    @property = House.new
    render "properties/#{params[:type].downcase}_form"
  end
end
