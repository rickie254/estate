class PropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]
  def show
    @property = Property.find(params[:id])
  end

  def new
    @@gallery = Gallery.new
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
    images = @@gallery.images
    images << gallery_params[:image]
    @@gallery.images = images

    if @@gallery.save
      p @@gallery.images.last.url
      render json: {image: @@gallery.images.last.url}
    else
      head :bad_request
    end
  end

  private

  def property_params
    params.require(params[:type].downcase.to_sym).permit(:title, :address, :district, :value, :deal,
    :global_area, :private_area, :featured, :profile, :position, :number_of_rooms, :condominium)
  end

  def gallery_params
    params.permit(:image)
  end

  def property_id
    if params[:type] then params["#{params[:type].downcase}_id".to_sym] else nil end
  end

  def propery_name
    "#{params[:type].downcase}"
  end

  def property_type
    params[:type].constantize if params[:type].in? PROPERTY_TYPES
  end
end
