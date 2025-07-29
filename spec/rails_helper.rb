# spec/rails_helper.rb
require 'spec_helper'
require 'database_cleaner/active_record'
require 'shoulda/matchers'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("Rails is running in production!") if Rails.env.production?

require 'rspec/rails'   # ← this is essential

# load support helpers
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# Shoulda matchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library        :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryBot::Syntax::Methods
  config.include RequestSpecHelper, type: :request
  config.include ControllerSpecHelper
  config.after(:suite) { Faker::UniqueGenerator.clear }

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
