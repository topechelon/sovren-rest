require 'employment_history.rb'

RSpec.describe SovrenRest::EmploymentHistory do
  before :all do
    @employer = "Stuff N' Things"
    @state = 'Ohio'
    @city = 'Canton'
    @description = 'Doing stuff, making things'
    @start_date = '2018-05'
    @end_date = 'current'
    @title = 'Stuff-Thinger'

    raw = File.read(File.expand_path('files/employment-history.json', __dir__))
    input = JSON.parse(raw)
    @employment_history = SovrenRest::EmploymentHistory.new(input['EmployerOrg'][0])
  end

  it 'should extract title' do
    expect(@employment_history.title).to eq(@title)
  end

  it 'should extract employer' do
    expect(@employment_history.employer).to eq(@employer)
  end

  it 'should extract state' do
    expect(@employment_history.state).to eq(@state)
  end

  it 'should extract city' do
    expect(@employment_history.city).to eq(@city)
  end

  it 'should extract description' do
    expect(@employment_history.description).to eq(@description)
  end

  it 'should extract start_date' do
    expect(@employment_history.start_date).to eq(@start_date)
  end

  it 'should extract end_date' do
    expect(@employment_history.end_date).to eq(@end_date)
  end
end
