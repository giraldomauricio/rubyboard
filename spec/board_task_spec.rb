require 'rspec'

describe 'BoardTask' do

  it 'should create different IDs' do
    bt1 = BoardTask.new({"name" => "Foo"})
    bt2 = BoardTask.new({"name" => "Bar"})
    expect(bt1.id).not_to be_nil
    expect(bt2.id).not_to be_nil
    expect(bt1.id != bt2.id).to eq true
  end
end