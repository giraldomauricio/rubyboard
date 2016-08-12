require 'yaml'

class BoardManager

  attr_accessor :path, :loaded, :structure

  def initialize(path = '.')
    @path      = path
    @loaded    = false
    @structure = {}
    if File.exist?(path + '/' + 'structure.yml')
      file = File.open(path + '/' + 'structure.yml', 'rb')
      file_contents = file.read
      @structure = YAML::load(file_contents)
      @loaded = true
    end
  end

  def get(row,column)
    return false if(!@structure[row] || !@structure[row].include?(column))
    Dir.glob(@path + "/#{row}/#{column}/*.yml")
  end

  def read(file_name)
    return false if(!file_name || !File.exist?(file_name))
    file = File.open(file_name, 'rb')
    file_contents = file.read
    YAML::load(file_contents)
  end

  def add(row,column,task)
    begin
      path = @path + "/#{row}/#{column}/#{task.id}.yml"
      file = File.open(path, 'w')
      file.write YAML::dump(task.toHash())
      file.close
      true
    rescue Exception => e
      puts e.message
      false
    end
  end

  def move(task, original_row, original_column, destination_row, destination_column)
    original_path = @path + "/#{original_row}/#{original_column}/#{task.id}.yml"
    destination_path = @path + "/#{destination_row}/#{destination_column}/#{task.id}.yml"
    return false if !File.exist?(@path + "/#{destination_row}/#{destination_column}/")
    return false if !File.exist?(original_path)
    begin
      File.rename original_path, destination_path
      true
    rescue
      false
    end
  end

end