require 'rspec'

describe 'TaskManager' do

  it 'should do loads a task' do
    tm = TaskManager.new
    task = tm.get('Expedite','Backlog','task1')
    expect(task['Task']['Name']).to eq 'Some name'
  end

  it 'should do add a task' do
    tm = TaskManager.new
    task = Task.new({Name: 'Test'})
    result = tm.add('Expedite','Backlog',task)
    expect(result).to eq true
  end

end