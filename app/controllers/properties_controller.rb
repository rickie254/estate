class PropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]
  include ApplicationHelper

  def home
  end

  def index
    if property_type
      properties = property_type.query_for_listing(params[:filter])
      @breadcrumbs = generate_breadcrumbs params[:filter]
    end
    properties ||= Property.all

    @properties = properties.page(params[:page]).per(2)
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @@gallery = Gallery.new
    @property = property_type.new

    @action = "create"
    render "properties/#{property_name}_form"
  end

  def edit
    @property = property_type.find(params[:id])
    @@gallery = @property.gallery

    @action = "update"
    render "properties/#{property_name}_form"
  end

  def create
    @property = property_type.new property_params
    @property.gallery = @@gallery

    unmask_fields

    if @property.save
      redirect_to @property, flash: { notice: "Criado com sucessso!" }
    else
      render "properties/#{property_name}_form"
    end
  end

  def update
    @property = property_type.find params[:id]

    unmask_fields

    if @property.save
      redirect_to @property, flash: { notice: "Atualizado com sucessso!" }
    else
      render "properties/#{property_name}_form"
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
      render json: {images: @@gallery.errors}
    end
  end

  def add_image
    images = @@gallery.images
    images << image_param[:image]
    @@gallery.images = images

    if @@gallery.save
      render json: {images: @@gallery.images}
    else
      render json: @@gallery.errors.messages, status: 406
    end
  end

  private

  def property_params
    params.require(params[:type].downcase.to_sym).permit PROPERTY_PARAMS
  end

  def image_param
    params.permit(:image)
  end

  def property_id
    if params[:type] then params["#{params[:type].downcase}_id".to_sym] else nil end
  end

  def property_name
    "#{params[:type].downcase}"
  end

  def property_type
    params[:type].constantize if params[:type].in? PROPERTY_TYPES
  end

  def unmask_fields
    global_area = property_params[:global_area]
    private_area = property_params[:private_area]

    @property.attributes = property_params
    @property.global_area = global_area.comma_to_delimiter if global_area
    @property.private_area = private_area.comma_to_delimiter if private_area
  end
end
