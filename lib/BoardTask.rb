class BoardTask

  attr_accessor :name, :id

  def initialize(vars = {})
    @name = vars['name'] if vars['name']
    @id = vars['id'] if vars['id']
  end

  def toHash()
    {'task' => {'name' => @name, 'id' => @id}}
  end

end