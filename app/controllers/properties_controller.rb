class PropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]
  before_action :initialize_gallery

  def show
    @property = Property.find(params[:id])
  end

  def new
    p @gallery
    @property = property_type.new
    render "properties/#{propery_name}_form"
  end

  def create
    @property = property_type.new property_params
    @property.gallery = @gallery

    if @property.save
      redirect_to @property
    else
      render "properties/#{propery_name}_form"
    end
  end

  def update_gallery
    p @gallery
    add_images(@gallery, [gallery_params[:image]])

    if @gallery.save
      head :created
    else
      head :bad_request
    end

  end

  private

  def initialize_gallery
    if property_id.nil?
      @gallery = Gallery.new
    else
      @gallery = property_type.find(property_id).gallery
    end
  end

  def property_params
    params.require(params[:type].downcase.to_sym).permit(:title, :address, :district, :value, :deal,
    :global_area, :private_area, :featured, :profile, :position, :number_of_rooms, :condominium)
  end

  def gallery_params
    params.require(:gallery).permit(:image)
  end

  def add_images gallery, new_images
    images = gallery.images
    images += new_images
    gallery.images = images
  end

  def property_id
    if params[:type] then params["#{params[:type].downcase}_id".to_sym] else nil end
  end

  def propery_name
    "#{params[:type].downcase}"
  end

  def property_type
    p params
    params[:type].constantize if params[:type].in? PROPERTY_TYPES
  end
end
