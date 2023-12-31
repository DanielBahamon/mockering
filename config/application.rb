require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mockering
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.exceptions_app = self.routes

    
    #FONTS
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('/app/assets/fonts')
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

    #I18N
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :en


    # CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://www.mockering.com' # Reemplaza con tu dominio
        resource '/cable', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
      end
    end

    #TimeZone
    config.time_zone = "America/Bogota"
    config.active_record.default_timezone = :utc

    config.active_record.yaml_column_permitted_classes = [ActiveSupport::HashWithIndifferentAccess]

  end
end
