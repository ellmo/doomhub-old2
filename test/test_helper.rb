ENV["RAILS_ENV"] = "test"

if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!
include ActionDispatch::TestProcess

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  ActiveRecord::Migration.maintain_test_schema!

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module MiniTest::Assertions
  def asserts_inclusion_of_all(includees, array)
    assert (includees - array) == []
  end

  def asserts_inclusion_of_none(includees, array)
    assert (array - includees) == array
  end
end

Array.infect_an_assertion :asserts_inclusion_of_all, :must_include_all
Array.infect_an_assertion :asserts_inclusion_of_none, :must_include_none

Minitest.after_run do
  dir = File.join(Rails.root, 'tmp', 'test-uploads')
  if File.directory? dir
    FileUtils.rm_rf dir
  end
end
