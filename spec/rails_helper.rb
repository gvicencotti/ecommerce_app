require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'devise'
require 'vcr'
require 'webmock/rspec'

# Require support files
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Maintain test schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Include Devise test helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers, type: :feature

  # Include FactoryBot syntax methods
  config.include FactoryBot::Syntax::Methods

  # Configure fixture paths
  config.fixture_paths = [ "#{::Rails.root}/spec/fixtures" ]

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # Infer spec type from file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!
end

# VCR configuration
VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<STRIPE_SECRET_KEY>') { Rails.application.credentials.dig(:stripe, :secret_key) }
end
