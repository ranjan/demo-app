require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'
require 'factory_bot_rails'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'simplecov'
require 'devise'
require "selenium-webdriver"

# Non-headless browser setting
WebMock.disable_net_connect!(allow_localhost: true)

Capybara.server = :puma, { Silent: true }
# Capybara.server_host = `hostname`.strip.downcase
# Capybara.server_port = 3002
# Capybara.default_max_wait_time = 10
# Capybara.save_path = "./tmp/capybara_output"
# Capybara.always_include_port = true
# Capybara.raise_server_errors = true

CHROME_OPTIONS = %w(
  --no-sandbox
  --disable-background-networking
  --disable-default-apps
  --disable-extensions
  --disable-sync
  --disable-gpu
  --disable-translate
  --headless
  --hide-scrollbars
  --metrics-recording-only
  --mute-audio
  --no-first-run
  --safebrowsing-disable-auto-update
  --ignore-certificate-errors
  --ignore-ssl-errors
  --ignore-certificate-errors-spki-list
  --user-data-dir=/tmp
).freeze

Capybara.register_driver :headless_chrome do |app|
  driver = Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: ::Selenium::WebDriver::Chrome::Options.new(
      args: CHROME_OPTIONS
    )
  )
  driver.browser.manage.window.size = Selenium::WebDriver::Dimension.new(1024, 740)
  driver
end

Capybara.register_driver :chrome do |app|
  driver = Capybara::Selenium::Driver.new(app, browser: :chrome)
  driver.browser.manage.window.size = ::Selenium::WebDriver::Dimension.new(1024, 740)
  driver
end

# For non-headless run, NON_HEADLESS=true bundle exec rspec
if ActiveModel::Type::Boolean.new.cast(ENV['NON_HEADLESS'])
  Capybara.javascript_driver = :chrome
  Capybara.default_driver = :chrome
else
  Capybara.default_driver = :headless_chrome
  Capybara.javascript_driver = :headless_chrome
end
# End of setting for non-headless and javascript support

SimpleCov.start

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  
  ## Local Setting
  config.include ControllerMacros, type: :controller
  config.include UserLogin

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation,
                               except: %w(ar_internal_metadata))
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, truncate: true) do
    # this allows us to run a test without it being wrapped in a transaction
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.append_after do
    DatabaseCleaner.clean
  end

  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
