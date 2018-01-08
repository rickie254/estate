class GalleryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWaveDirect::Uploader

  # before :store, :remember_cache_id
  # after :store, :delete_tmp_dir
  # def remember_cache_id(new_file)
  #   @cache_id_was = cache_id
  # end
  #
  # def delete_tmp_dir(new_file)
  #   if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
  #     FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
  #   end
  # end

  version :small do
    process :efficient_conversion => [200, -1]
  end

  version :large do
    process :efficient_conversion => [1080, -1]
  end

  def filename
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{secure_token}.#{file.extension}" if original_filename.present?
  end

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def extension_whitelist
    %w(jpg jpeg png bmp tif tiff)
  end

  protected

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    unless model.instance_variable_get(media_original_filenames_var)
      model.instance_variable_set(media_original_filenames_var, {})
    end

    unless model.instance_variable_get(media_original_filenames_var).map{|k,v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({"#{original_filename}": SecureRandom.uuid})
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end

  def efficient_conversion(width, height)
    manipulate! do |img|
      img.format("jpg") do |c|
        c.background '#FFFFFF'
        c.alpha 'remove'
        c.auto_orient
        c.fuzz        "3%"
        c.trim
        c.resize      "#{width}x#{height}>"
        c.resize      "#{width}x#{height}<"
      end

      img
    end
  end
end
