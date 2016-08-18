require 'spec_helper'
require 'rack/test'

describe IndexController do

  def app() ApiController end

  context 'Api' do

    it 'should allow accessing the home page' do
      get '/all', {}, { 'rack.session' => { user: 'foo' } }
      expect(last_response.body).to include('Some new task')
    end

    it 'should add a task' do
      get '/add',  params = {name: 'foo', detail: 'bar'}
      task_id = last_response.body.gsub('"','')
      task_file = ENV['TEST_BOARD_LOCATION'] + '/Standard/Backlog/' + task_id + '.yml'
      expect(File.exist?(task_file))
      File.delete(task_file)
    end

    it 'should add a task and then move it' do
      get '/add',  params = {name: 'foo', detail: 'bar'}
      task_id = last_response.body.gsub('"','')
      task_file = ENV['TEST_BOARD_LOCATION'] + '/Standard/Backlog/' + task_id + '.yml'
      expect(File.exist?(task_file))
      get '/move',  params = {id: task_id, to_row: 'Expedite', to_column: 'Deployed'}
      move_result = last_response.body.gsub('"','')
      expect(move_result).to eq 'true'
      task_file = ENV['TEST_BOARD_LOCATION'] + '/Expedite/Deployed/' + task_id + '.yml'
      expect(File.exist?(task_file))
      File.delete(task_file)
    end

  end

end
