require 'yaml'

class BoardLoader

  attr_accessor :path, :loaded, :structure

  def initialize(path = '.')
    @path      = path
    @loaded    = false
    @structure = []
    if(File.exist?(path + '/' + 'structure.yml'))
      file = File.open(path + '/' + 'structure.yml', 'rb')
      file_contents = file.read
      @structure = YAML::load(file_contents)
      @loaded = true
    end
  end

  def get(row,column)
    return false if(@structure[row] && !@structure[row].include?(column))
    Dir.glob(@path + "/#{row}/#{column}/*.yml")
  end

  def read(file_name)
    return false if(!File.exist?(file_name))
    file = File.open(file_name, 'rb')
    file_contents = file.read
    YAML::load(file_contents)
  end

end