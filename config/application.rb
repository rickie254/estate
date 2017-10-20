require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CorretorDeImoveis
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = 'America/Sao_Paulo'
    config.i18n.default_locale = 'pt-BR'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
    	g.test_framework :rspec, :view_specs => false,
    													 :controller_specs => false,
    													 :helper_specs => false,
    													 :routing_specs => false,
    													 :request_specs => false
    end

    ENV['S3_KEY'] = "AKIAILDZNRIO7FEB3HKQ"
    ENV['S3_SECRET'] = "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"
  end
end
