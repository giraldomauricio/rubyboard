ENV['CODECLIMATE_REPO_TOKEN'] = '69f27a812b6ee2c69d22e648a34c3cb71ef339a1163d0ee453c7558bf703c516'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rubygems'
require 'sinatra'
require 'dotenv'

require 'rack/test'
require 'rspec'


ENV['RACK_ENV'] = 'test'

Dotenv.load

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
#require File.expand_path("../../config/environment", __FILE__)
require './controllers/ApplicationController.rb'
Dir[('./lib/*.rb')].each { |f| require f }
Dir[('./controllers/*.rb')].each { |f| require f }
#require 'rspec/rails'
#require 'rspec/autorun'


module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
# If you use RSpec 1.x you should use this instead:
# Spec::Runner.configure { |c| c.include RSpecMixin }

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  #config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  #config.order = "random"



end
