require 'spec_helper'
require 'rack/test'

describe IndexController do

  def app() IndexController end

  context 'Api' do

    it 'should allow accessing the home page' do
      get '/', {}, { 'rack.session' => { user: 'foo' } }
      expect(last_response.body).to include('Some new task')
    end

  end

end
