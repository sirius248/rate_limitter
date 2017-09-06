require 'spec_helper'
require 'rack/test'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  include Rack::Test::Methods

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
