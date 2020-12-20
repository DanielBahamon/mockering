Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.action_cable.mount_path = "/cable"
  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end



  Recaptcha.configure do |config|
    config.site_key  = '6Le7Ig4aAAAAAE34nhzhZZK1AySTj_5sP9dnJHV1'
    config.secret_key = '6Le7Ig4aAAAAABLbijiHKtZpTMGij3s386t5ZrO9'
  end

  config.action_cable.url = "ws://localhost:3000/cable"

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    enable_starttls_auto: true,
    authentication: 'plain',
    domain: 'localhost:3000',
    user_name: 'mr.sublimen@gmail.com',
    password: 'ElArteDeVivir69$&'
  }


  #ActionMailer::Base.smtp_settings = {
  #    :user_name => ENV['apikey'],
  #    :password => ENV['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'],
  #    :domain => 'localhost:3000',
  #    :address => 'smtp.sendgrid.net',
  #    :port => 587,
  #    :authentication => :plain,
  #    :enable_starttls_auto => true
  #}

  config.paperclip_defaults = {
    storage: :s3,
    path: ':class/:attachment/:id/:style/:filename',
    s3_host_name: 's3-sa-east-1.amazonaws.com',
    s3_credentials: {
      bucket: 'airpikachu6',
      access_key_id: 'AKIAIR3RVUMFAIL2GU2A',
      secret_access_key: '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',
      s3_region: 'sa-east-1'
    }
  }

end
