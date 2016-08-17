require 'yaml'
require './lib/AppLogger.rb'

class BoardManager

  attr_accessor :path, :loaded, :structure

  def initialize(path = '.')
    AppLogger.info("Initializing using path: #{path}",'BoardManager','initialize')
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
    AppLogger.info("Row: #{row}, Column: #{column}",'BoardManager','get')
    return false if(!@structure[row] || !@structure[row].include?(column))
    Dir.glob(@path + "/#{row}/#{column}/*.yml")
  end

  def read(file_name)
    AppLogger.info("Reading: #{file_name}",'BoardManager','get')
    return false if(!file_name || !File.exist?(file_name))
    file = File.open(file_name, 'rb')
    file_contents = file.read
    YAML::load(file_contents)
  end

  def add(row,column,task)
    AppLogger.info("Adding: #{row}, Column: #{column}, task: #{task.inspect}",'BoardManager','add')
    begin
      path = @path + "/#{row}/#{column}/#{task.id}.yml"
      file = File.open(path, 'w')
      file.write YAML::dump(task.toHash())
      file.close
      true
    rescue Exception => e
      AppLogger.error("Error adding task: #{e.message}",'BoardManager','move')
      false
    end
  end

  def getAll()
    getStructure(@path)
  end

  def find(id)
    task_data = getStructure(@path, id)
    BoardTask.new(task_data['task'])
  end
  
  def getStructure(path, id = nil)
    result = {}
    Dir.foreach(path) do |entry|
      next if (!isABoardTask(entry))
      full_path = File.join(path, entry)
      if File.directory?(full_path)
        result[entry] = {}
        Dir.foreach(full_path) do |task|
          next if (!isABoardTask(task))
          full_path_tasks = File.join(path, entry, task)
          if File.directory?(full_path_tasks)
            result[entry][task] = []
            Dir.foreach(full_path_tasks) do |individual_task|
              next if (!isABoardTask(individual_task))
              task_file_name = File.join(path, entry, task, individual_task)
              task_data = read(task_file_name)
              task_data['task']['_swimline'] = entry
              task_data['task']['_column'] = task
              result[entry][task] << task_data
              return task_data if(!id.nil? && task_data['task']['id'] == id)
            end
          end

        end
      end
    end
    result
  end

  def isABoardTask(file_name)
    !(file_name == '..' || file_name == '.' || file_name == 'readme.md')
  end

  def moveTo(task_id, destination_row, destination_column)
    task_data = find(task_id)
    original_row = task_data._swimline
    original_column = task_data._column
    move(task_data, original_row, original_column, destination_row, destination_column)
  end


  def move(task, original_row, original_column, destination_row, destination_column)
    AppLogger.info("From_row: #{original_row}, From_column: #{original_column}, To_row: #{destination_row}, To_column: #{destination_column}, task: #{task.inspect}",'BoardManager','move')
    original_path = @path + "/#{original_row}/#{original_column}/#{task.id}.yml"
    destination_path = @path + "/#{destination_row}/#{destination_column}/#{task.id}.yml"
    return false if !File.exist?(@path + "/#{destination_row}/#{destination_column}/")
    return false if !File.exist?(original_path)
    begin
      File.rename original_path, destination_path
      true
    rescue
      AppLogger.error('Cannot move task','BoardManager','move')
      false
    end
  end

end