source "https://rubygems.org"

ruby "3.2.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
# gem "pg", "~> 1.1"
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem 'letter_opener_web'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "minitest-reporters"
  gem 'factory_bot'
  gem 'minitest'
  gem 'rails-controller-testing'
end

group :production do
  # gem "pg", "1.3.5"
  # gem "aws-sdk-s3", "1.157", require: false
  gem "aws-sdk-s3"

end

# エラー日本語化
gem "rails-i18n"
gem 'devise-i18n'

# devise
gem "devise"

# bootstrap
gem 'bootstrap'
gem 'mini_racer'
gem 'sassc-rails'

# form
gem 'simple_form'

# 画像
gem "active_storage_validations"
gem "image_processing"

# 環境変数
gem 'dotenv-rails'

# ページネーション
gem 'kaminari'

# SEO対策
#  //サイトマップ生成→検索エンジンが構造理解する為
gem 'sitemap_generator'

#  // ベストプラクティスをチェックするコードチェッカー
# gem 'rails_best_practices'

#  //ページごとのメタタグを簡単に管理
gem 'meta-tags'

# スパム対策　Google reCAPTCHA
# gem 'recaptcha',  require: "recaptcha/rails"

# ジョブ
# gem 'whenever', require: false
