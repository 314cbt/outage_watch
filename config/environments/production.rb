# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # --- Boot & caching ---
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # --- Assets / static files ---
  # In containers behind a proxy, serve precompiled assets when the env var is set.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.compile = false

  # --- Active Storage (S3 in prod) ---
  config.active_storage.service = :amazon

  # --- SSL / security ---
  config.force_ssl = true
  config.assume_ssl = true
  # Don’t redirect /up so ALB health checks succeed.
  config.ssl_options = { redirect: { exclude: ->(req) { req.path == "/up" } } }

  # Allow your domain and the ALB DNS (for health checks).
  config.hosts = [
    "www.clemsonthompson.com",
    # Add the apex when you use it:
    # "clemsonthompson.com",
    /\A.*\.elb\.amazonaws\.com\z/
  ]
  # Skip Host Authorization for /up to avoid 403s from health checks.
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  # --- Logging ---
  base_logger = ActiveSupport::Logger.new(STDOUT)
  base_logger.formatter = ::Logger::Formatter.new
  config.logger = ActiveSupport::TaggedLogging.new(base_logger)
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # --- Mailers / I18n / misc ---
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end
