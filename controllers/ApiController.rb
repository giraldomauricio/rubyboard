require 'sinatra'
require 'json'
require './lib/BoardManager'
require './lib/BoardTask'
require 'dotenv'
require 'logger'

Dotenv.load

class ApiController < ApplicationController

  attr_accessor :header, :board_location

  enable :sessions

  before do
    if(ENV['RACK_ENV'] == 'test')
      @board_location = ENV['TEST_BOARD_LOCATION']
    else
      @board_location = ENV['PROD_BOARD_LOCATION']
    end
  end

  get '/all' do
    bm = BoardManager.new(@board_location)
    list = bm.getAll()
    list.to_json
  end

  get '/move' do
    bm = BoardManager.new(@board_location)
    result = bm.moveTo(params['id'],params['to_row'],params['to_column'])
    result.to_json
  end


  get '/add' do
    bm = BoardManager.new(@board_location)
    name = params['name']
    detail = params['detail']
    assignedTo = params['assignedTo']
    task = BoardTask.new({'name' => name, 'detail' => detail, 'assignedTo' => assignedTo})
    result = bm.add('Standard','Backlog',task)
    result = task.id if result
    result.to_json
  end

end
