class PropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]

  def index
    case params[:type]
    when "Apartment"
      if params[:number_of_rooms]
        @properties = Apartment.all.where(number_of_rooms: params[:number_of_rooms])
      elsif params[:number_of_boxes]
        @properties = Apartment.all.where(number_of_boxes > 0)
      elsif params[:roof]
        @properties = Apartment.all.where(roof: true)
      end
    when "House"
      if params[:number_of_rooms]
        @properties = Apartment.all.where(number_of_rooms: params[:number_of_rooms])
      end
    end

    @properties ||= Property.all
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @@gallery = Gallery.new
    @property = property_type.new

    @action = "create"
    render "properties/#{propery_name}_form"
  end

  def edit
    @property = property_type.find(params[:id])
    @@gallery = @property.gallery

    @action = "update"
    render "properties/#{propery_name}_form"
  end

  def create
    @property = property_type.new property_params
    @property.gallery = @@gallery

    if @property.save
      redirect_to @property
    else
      render "properties/#{propery_name}_form"
    end
  end

  def update
    @property = property_type.find params[:id]

    if @property.update! property_params
      redirect_to @property
    else
      render "properties/#{propery_name}_form"
    end
  end

  def get_images
    render json: {images: @@gallery.images}
  end

  def remove_image
    remain_images = @@gallery.images
    deleted_image = remain_images.delete_at(params[:index].to_i) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @@gallery.images = remain_images

    if @@gallery.save
      render json: {images: @@gallery.images}
    else
      head :bad_request
    end
  end

  def add_image
    images = @@gallery.images
    images << image_param[:image]
    @@gallery.images = images

    if @@gallery.save
      render json: {images: @@gallery.images}
    else
      head :bad_request
    end
  end

  private

  def property_params
    params.require(params[:type].downcase.to_sym).permit(:title, :address, :district, :value, :deal,
    :global_area, :private_area, :featured, :profile, :position, :number_of_rooms, :condominium)
  end

  def image_param
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
