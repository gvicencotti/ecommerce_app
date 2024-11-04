source "https://rubygems.org"

ruby "3.3.5"


gem "rails", "~> 7.1.5"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
#gem "turbo-rails"
#gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'ostruct'

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0'
end

group :development do
  gem "web-console"
end

group :test do
  gem 'capybara', '~> 3.37'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing', '~> 1.0'
end
