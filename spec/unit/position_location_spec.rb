require 'position_location.rb'

RSpec.describe SovrenRest::PositionLocation do
  before :all do
    @city = 'Canton'
    @state = 'Ohio'
    @country = 'US'

    raw = File.read(File.expand_path('files/employment-history.json', __dir__))
    input = JSON.parse(raw).dig('EmployerOrg', 0, 'PositionHistory', 0, 'OrgInfo')
    @location = SovrenRest::PositionLocation.new(input)
  end

  it 'should extract city' do
    expect(@location.city).to eq(@city)
  end

  it 'should extract state' do
    expect(@location.state).to eq(@state)
  end

  it 'should extract country' do
    expect(@location.country).to eq(@country)
  end
end
