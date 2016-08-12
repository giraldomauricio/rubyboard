class TaskManager

  def get(row,column,task)
    bl = BoardLoader.new(ENV['board_location'])
    tasks = bl.get(row,column)
    task_file = tasks.select{|task_name| task_name.include?(task)}
    bl.read(task_file[0])
  end

end