require 'carrierwave/orm/activerecord'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  config.fog_provider = 'fog/aws'                        # required
  config.storage = :fog
  config.fog_public = false

  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV['S3_KEY'],                # required
    aws_secret_access_key: ENV['S3_SECRET'],             # required
    region:                'sa-east-1'                   # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = ENV['S3_BUCKET_NAME']                          # required
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end
