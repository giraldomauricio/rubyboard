require 'sinatra'
require 'json'
require './lib/BoardManager'
require './lib/BoardTask'
require 'dotenv'
require 'logger'

Dotenv.load

class IndexController < ApplicationController

  attr_accessor :header, :board_location

  enable :sessions

  before do
    if(ENV['RACK_ENV'] == 'test')
      @board_location = ENV['TEST_BOARD_LOCATION']
    else
      @board_location = ENV['PROD_BOARD_LOCATION']
    end
  end

  get '/' do
    bm = BoardManager.new(@board_location)
    list = bm.getAll()
    erb :index, :locals => {'list' => list}
  end

end
