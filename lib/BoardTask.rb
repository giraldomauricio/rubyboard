require 'securerandom'

class BoardTask

  attr_accessor :name, :id, :_swimline, :_column

  def initialize(vars = {})
    @name = vars['name'] if vars['name']
    @_swimline = vars['_swimline'] if vars['_swimline']
    @_column = vars['_column'] if vars['_column']
    @name = vars['name'] if vars['name']
    @id =  (!vars['id'].nil?) ? vars['id'] : SecureRandom.uuid
  end

  def toHash()
    {'task' => {'name' => @name, 'id' => @id}}
  end

end