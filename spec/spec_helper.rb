# frozen_string_literal: true
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'redux_ussd'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
