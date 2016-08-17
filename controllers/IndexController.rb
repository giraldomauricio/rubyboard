require 'sinatra'
require 'json'
require './lib/BoardManager'
require './lib/BoardTask'
require './lib/AssetHandler'
require 'dotenv'
require 'logger'

Dotenv.load

class IndexController < ApplicationController

  attr_accessor :header

  enable :sessions

  before do
    # Any initialization
  end

  get '/' do
    bm = BoardManager.new(ENV['BOARD_LOCATION'])
    list = bm.getAll()
    erb :index, :locals => {"list" => list}
  end

  get '/boards' do
    erb :boards
  end

end
