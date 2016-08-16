require 'rspec'

describe 'BoardLoader' do

  before(:each) do
    File.delete('./spec/sample_board/Expedite/Backlog/foo.yml') if(File.exists?('./spec/sample_board/Expedite/Backlog/foo.yml'))
    File.delete('./spec/sample_board/Expedite/WIP/foo.yml') if(File.exists?('./spec/sample_board/Expedite/WIP/foo.yml'))
  end

  after(:all) do
    File.delete('./spec/sample_board/Expedite/Backlog/foo.yml') if(File.exists?('./spec/sample_board/Expedite/Backlog/foo.yml'))
    File.delete('./spec/sample_board/Expedite/WIP/foo.yml') if(File.exists?('./spec/sample_board/Expedite/WIP/foo.yml'))
  end

  context 'Vanilla cases' do

    it 'should Load the Structure' do
      bl = BoardManager.new
      expect(bl.path).to eq '.'
    end

    it 'should read the structure YAML' do
      bl = BoardManager.new('./spec/sample_board')
      expect(bl.path).to eq './spec/sample_board'
      expect(bl.loaded).to eq true
      expect(bl.structure.count).to eq 2
      expect(bl.structure['Expedite'].count).to eq 3
      expect(bl.structure['Expedite'][0]).to eq 'Backlog'
    end

    it 'should get the tasks in a specific column' do
      bl = BoardManager.new('./spec/sample_board')
      tasks = bl.get('Expedite','Backlog')
      expect(tasks.count).to eq 1
    end

    it 'should read the task in a specific column' do
      bl = BoardManager.new('./spec/sample_board')
      tasks = bl.get('Expedite','Backlog')
      task = bl.read(tasks[0])
      expect(task['task']['name']).to eq 'Some new task'
    end

    it 'should add a task in a specific column' do
      bl = BoardManager.new('./spec/sample_board')
      task = BoardTask.new({'name' => 'Some new task', 'id' => 'foo'})
      result = bl.add('Expedite','Backlog', task)
      expect(result).to eq true
      expect(File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
    end

    it 'should get all tasks' do
      bl = BoardManager.new('./spec/sample_board')
      ENV['board_location'] = './spec/sample_board'
      tasks = bl.getAll()
      # puts tasks
      # expected = {'Expedite' => {'Backlog' => ['task1'], 'Deployed' => ['task2'], 'WIP' => []}, 'Standard' => {'Backlog' => [], 'Deployed' => [], 'WIP' => []}}
      expected = {'Expedite'=>{'Backlog'=>[{'task'=>{'name'=>'Some new task', 'id'=>'task1'}, '_swimline'=>'Expedite', '_column'=>'Backlog'}], 'Deployed'=>[{'task'=>{'name'=>'Some new task', 'id'=>'task2'}, '_swimline'=>'Expedite', '_column'=>'Deployed'}], 'WIP'=>[]}, 'Standard'=>{'Backlog'=>[], 'Deployed'=>[], 'WIP'=>[]}}
      expect(tasks).to eq expected
    end

    it 'should add and move a task to a specific column' do
      bl = BoardManager.new('./spec/sample_board')
      task = BoardTask.new({'name' => 'Some new task', 'id' => 'foo'})
      result = bl.add('Expedite','Backlog', task)
      expect(result).to eq true
      expect(File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
      result = bl.move(task, 'Expedite','Backlog', 'Expedite', 'WIP')
      expect(result).to eq true
      expect(!File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
      expect(File.exist?('./spec/sample_board/Expedite/WIP/foo.yml'))
    end

  end

  context 'Failing cases' do

    it 'should return false if cannot find read the structure YAML' do
      bl = BoardManager.new('./spec/foo')
      expect(bl.path).to eq './spec/foo'
      expect(bl.loaded).to eq false
      expect(bl.structure.count).to eq 0
    end

    it 'should get nothing in a specific column because it simply does not exists as board' do
      bl = BoardManager.new('./spec/foo')
      tasks = bl.get('Expedite','Backlog')
      expect(tasks).to eq false
    end

    it 'should get nothing in a specific column because it simply does not exists as column' do
      bl = BoardManager.new('./spec/sample_board')
      tasks = bl.get('Expedited','Backlog')
      expect(tasks).to eq false
    end

    it 'should get nothing in a specific column because it simply does not exists as row' do
      bl = BoardManager.new('./spec/sample_board')
      tasks = bl.get('Expedited','Backlogs')
      expect(tasks).to eq false
    end

    it 'should not read un-existing task in a specific column' do
      bl = BoardManager.new('./spec/sample_board')
      tasks = bl.get('Expedite','WIP')
      task = bl.read(tasks[0])
      expect(task).to eq false
    end

    it 'should not add a task in an unknown column' do
      bl = BoardManager.new('./spec/sample_board')
      task = BoardTask.new({'name' => 'Some new task', 'id' => 'foo'})
      result = bl.add('Expedited','Backlog', task)
      expect(result).to eq false
      expect(!File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
    end

    it 'should add and not move a task to a non existing column' do
      bl = BoardManager.new('./spec/sample_board')
      task = BoardTask.new({'name' => 'Some new task', 'id' => 'foo'})
      result = bl.add('Expedite','Backlog', task)
      expect(result).to eq true
      expect(File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
      result = bl.move(task, 'Expedited','Backlog', 'Expedite', 'WIP')
      expect(result).to eq false
      expect(File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
      result = bl.move(task, 'Expedite','Backlog', 'Expedited', 'WIP')
      expect(result).to eq false
      expect(File.exist?('./spec/sample_board/Expedite/Backlog/foo.yml'))
    end

  end

end