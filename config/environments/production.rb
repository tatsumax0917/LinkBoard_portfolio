require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"], config/master.key, or an environment
  # key such as config/credentials/production.key. This key is used to decrypt credentials (and other encrypted files).

  # 本番環境でマスターキーの存在を確認する
  config.require_master_key = true

  # ========================================
  #   アセットコンパイル系の設定
  # ========================================
  # Disable serving static files from `public/`, relying on NGINX/Apache to do so instead.
  # 静的ファイルの提供をするかの設定（false: 無効, true: 有効)
  # config.public_file_server.enabled = false
  config.public_file_server.enabled = true

  # Compress CSS using a preprocessor.
  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fall back to assets pipeline if a precompiled asset is missed.
  # 事前にコンパイルされたアセットのみを使用（false: 事前コンパイル, true: 動的コンパイル）
  config.assets.compile = false

  # アセットパイプラインを有効にするための設定(false: 無効, true: 有効)
  # config.assets.enabled = true

  # コンパイル時にファイル名にダイジェスト付与(false: 付与しない, true: 付与する)
  # config.assets.digest = true

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # アップロードされたファイルをAWSに保存する
  config.active_storage.service = :amazon


  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  # Can be used together with config.force_ssl for Strict-Transport-Security and secure cookies.
  # config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # "info" includes generic and useful information about system operation, but avoids logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII). If you
  # want to log everything, set the level to "debug".
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "app_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  # ==================
  #   ActionMailerの設定
  # ==================
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: Rails.application.credentials.dig(:smtp, :address),
    port: Rails.application.credentials.dig(:smtp, :port),
    domain: Rails.application.credentials.dig(:smtp, :domain),
    user_name: Rails.application.credentials.dig(:smtp, :user_name),
    password: Rails.application.credentials.dig(:smtp, :password),
    authentication: 'plain',
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = { host: 'link-board.com', protocol: 'https' }
  # config.action_mailer.asset_host = 'https://link-board.com'

  # ==================
  #   ホストの設定
  # ==================
  config.hosts << 'link-board.onrender.com'
  config.hosts << 'www.link-board.com'
  config.hosts << 'link-board.com'

end
