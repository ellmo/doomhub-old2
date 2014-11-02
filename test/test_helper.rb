ENV["RAILS_ENV"] = "test"

if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/reporters"
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }
Minitest::Reporters.use!
include ActionDispatch::TestProcess

class ActiveSupport::TestCase
  ActiveRecord::Migration.maintain_test_schema!
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
  include Support::Devise
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
