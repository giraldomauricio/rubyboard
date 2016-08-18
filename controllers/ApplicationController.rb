# ApplicationController.rb
class ApplicationController < Sinatra::Base
  # helpers ApplicationHelper

  attr_accessor :logger

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  # use AssetHandler

end
