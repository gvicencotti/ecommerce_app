source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "devise"
gem "cancancan"
gem "stripe"
gem "ostruct"
gem "httparty"
gem "jquery-rails"

# frontend styling
gem "bootstrap", "~> 5.1.3"
gem "sassc-rails"

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.0.0"
  gem "capybara"
  gem "factory_bot_rails"
  gem "webmock"
  gem "vcr"
end

group :development do
  gem "web-console"
end

group :test do
  gem "selenium-webdriver"
  gem "rails-controller-testing"
  gem "database_cleaner-active_record"
end

gem "faker", "~> 3.5"
