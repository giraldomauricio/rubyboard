require 'sinatra/base'
require 'dotenv'

Dotenv.load

# pull in the helpers and controllers
require './controllers/ApplicationController.rb'
Dir.glob('./controllers/*.rb').each { |file| require file }

# map the controllers to routes
# map('/example') { run ExampleController }
# map('/mobile') { run MobileController }
# map('/release') { run ReleaseController }
# map('/tracker') { run TrackerController }
# map('/slack') { run SlackController }
# map('/chargebacks') { run ChargeBacksController }
map('/') { run IndexController }
