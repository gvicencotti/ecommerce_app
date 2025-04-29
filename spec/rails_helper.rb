require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'devise'
require 'vcr'
require 'webmock/rspec'
require 'database_cleaner-active_record'
require 'capybara/rails'
require 'rails-controller-testing'

Rails::Controller::Testing::TemplateAssertions
Rails::Controller::Testing::Integration
Rails::Controller::Testing::TestProcess

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

Capybara.server_host = '127.0.0.1'
Capybara.app_host = 'http://127.0.0.1:3000'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers, type: :feature
  config.include FactoryBot::Syntax::Methods
  config.include Rails::Controller::Testing::TemplateAssertions, type: :controller
  config.include Rails::Controller::Testing::Integration, type: :controller
  config.include Rails::Controller::Testing::TestProcess, type: :controller

  config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
