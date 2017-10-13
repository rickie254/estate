class ImagesController < ApplicationController
  before_action :set_property

  def create
    add_more_images(images_params[:images])
    flash[:error] = "Failed uploading images" unless @property.save
    redirect_to :back
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @property.save
    redirect_to :back
  end

  private

  def set_property
    @property = property_type.find(params["#{params[:type].downcase}_id".to_sym])
  end

  def add_more_images(new_images)
    images = @property.images
    images += new_images
    @property.images = images
  end

  def remove_image_at_index(index)
    remain_images = @property.images # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @property.images = remain_images # re-assign back
  end

  def images_params
    params.require(:property).permit({images: []}) # allow nested params as array
  end

  def property_type
    params[:type].constantize if params[:type].in? PROPERTY_TYPES
  end
end
