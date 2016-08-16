require 'securerandom'

class BoardTask

  attr_accessor :name, :id, :_swimline, :_column, :detail

  def initialize(vars = {})
    @name = vars['name'] if vars['name']
    @detail = vars['detail'] if vars['detail']
    @_swimline = vars['_swimline'] if vars['_swimline']
    @_column = vars['_column'] if vars['_column']
    @name = vars['name'] if vars['name']
    @id =  (!vars['id'].nil?) ? vars['id'] : SecureRandom.uuid
  end

  def toHash()
    {'task' => {'name' => @name, 'detail' => @detail, 'id' => @id}}
  end

end