require 'sinatra'
require 'json'
require './lib/BoardManager'
require './lib/BoardTask'
require './lib/AssetHandler'
require 'dotenv'
require 'logger'

Dotenv.load

class ApiController < ApplicationController

  attr_accessor :header

  enable :sessions

  before do
    # Any initialization
  end

  get '/all' do
    bm = BoardManager.new(ENV['board_location'])
    list = bm.getAll()
    list.to_json
  end

  get '/move' do
    bm = BoardManager.new(ENV['board_location'])
    result = bm.move(params['id'],params['from_row'],params['from_column'],params['to_row'],params['to_column'])
    result.to_json
  end

end
