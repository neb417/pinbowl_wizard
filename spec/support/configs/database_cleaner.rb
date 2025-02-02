# frozen_string_literal: true

# References...
# https://avdi.codes/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
# https://github.com/DatabaseCleaner/database_cleaner/issues/447
# https://stackoverflow.com/questions/9927671/rspec-database-cleaner-not-cleaning-correctly

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
