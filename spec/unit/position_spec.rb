require 'position.rb'

RSpec.describe SovrenRest::Position do
  before :all do
    @current = 'true'
    @department = 'Stuff N\' Things'
    @start_date = '2018-05'
    @end_date = 'current'

    raw = File.read(File.expand_path('files/employment-history.json', __dir__))
    input = JSON.parse(raw).dig('EmployerOrg', 0, 'PositionHistory', 0)
    @position = SovrenRest::Position.new(input)
  end

  it 'should extract current' do
    expect(@position.current).to eq(@current)
  end

  it 'should extract title' do
    expect(@position.title).to be_nil
  end

  it 'should extract department' do
    expect(@position.department).to eq(@department)
  end

  it 'should extract start_date' do
    expect(@position.start_date).to eq(@start_date)
  end

  it 'should extract end_date' do
    expect(@position.end_date).to eq(@end_date)
  end

  it 'should extract description' do
    expect(@position.description).not_to be_nil
  end

  it 'should extract location' do
    expect(@position.location).not_to be_nil
  end

  it 'should extract category' do
    expect(@position.category).not_to be_nil
  end

  it 'should extract metadata' do
    expect(@position.metadata).not_to be_nil
  end
end
