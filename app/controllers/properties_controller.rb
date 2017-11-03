class PropertiesController < ApplicationController
  before_action :authenticate_admin!, except: [:home, :index, :show]
  include ApplicationHelper

  def show() @property = Property.find(params[:id]) end

  def new() initialize_form end

  def edit() initialize_form end

  def get_images() render json: {images: @@gallery.images} end

  def get_extra_list() render json: {list: @@extra_list.list} end

  def home
    @properties = Property.where(is_featured: true)
  end

  def index
    properties = property_type.query_for_listing(params[:filter]) if property_type
    properties ||= Property.query_for_listing(params[:filter])

    @breadcrumbs = generate_breadcrumbs params[:filter]
    @properties = properties.page(params[:page])
  end

  def create
    @property = property_type.new property_params
    @property.gallery = @@gallery
    @property.extra_list = @@extra_list

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

  def destroy
    @property = property_type.find(params[:id]) if params[:id]

    if @property.destroy
      redirect_to root_path, flash: { notice: "Excluído com sucessso!" }
    else
      render "properties/#{property_name}_form"
    end
  end

  def add_extra
    extra = extra_param[:extra]

    if !extra.nil? && !extra.blank?
      list = @@extra_list.list
      list << extra
      @@extra_list.list = list

      if @@extra_list.save
        render json: {list: @@extra_list.list}
      end
    else
      render json: "não pode ficar em branco", status: 406
    end
  end

  def add_image
    images = @@gallery.images
    images << image_param[:image]
    @@gallery.images = images

    if @@gallery.valid?
      if @@gallery.save
        render json: {images: @@gallery.images}
      end
    else
      render json: @@gallery.errors.messages, status: 406
      @@gallery.images.pop
    end
  end

  def remove_extra
    remain_extras = @@extra_list.list
    deleted_extra = remain_extras.delete_at(params[:index].to_i)
    @@extra_list.list = remain_extras

    if @@extra_list.save
      render json: {list: @@extra_list.list}
    end
  end

  def remove_image
    remain_images = @@gallery.images
    deleted_image = remain_images.delete_at(params[:index].to_i) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @@gallery.images = remain_images

    if @@gallery.save
      render json: {images: @@gallery.images}
    else
      render json: @@gallery.errors.messages, status: 400
    end
  end

  def set_main_image
    images = @@gallery.images
    images.insert(0, images.delete_at(params[:index].to_i))
    @@gallery.images = images

    if @@gallery.save
      render json: {images: @@gallery.images}
    else
      render json: @@gallery.errors.messages, status: 400
    end
  end

  def initialize_form
    @property = property_type.find(params[:id]) if params[:id]
    @property ||= property_type.new

    @@gallery = @property.gallery || Gallery.new
    @@extra_list = @property.extra_list || ExtraList.new

    render "properties/#{property_name}_form"
  end

  private

  def property_params
    params.require(params[:type].downcase.to_sym).permit PROPERTY_PARAMS
  end

  def image_param
    params.permit(:image)
  end

  def extra_param
    params.permit(:extra)
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
