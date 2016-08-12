require 'rspec'

describe 'BoardLoader' do

  it 'should Load the Structure' do
    bl = BoardLoader.new
    expect(bl.path).to eq '.'
  end

  it 'should read the structure YAML' do
    bl = BoardLoader.new('./spec/sample_board')
    expect(bl.path).to eq './spec/sample_board'
    expect(bl.loaded).to eq true
    expect(bl.structure.count).to eq 2
    expect(bl.structure['Expedite'].count).to eq 3
    expect(bl.structure['Expedite'][0]).to eq 'Backlog'
  end

  it 'should get the tasks in a specific column' do
    bl = BoardLoader.new('./spec/sample_board')
    tasks = bl.get('Expedite','Backlog')
    expect(tasks.count).to eq 1
  end

  it 'should read the task in a specific column' do
    bl = BoardLoader.new('./spec/sample_board')
    tasks = bl.get('Expedite','Backlog')
    task = bl.read(tasks[0])
    expect(task['Task']['Name']).to eq 'Some name'
  end

end