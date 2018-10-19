require 'employer.rb'

RSpec.describe SovrenRest::Employer do
  before :all do
    @name = 'Stuff N\' Things'

    raw = File.read(File.expand_path('files/employment-history.json', __dir__))
    input = JSON.parse(raw)
    @employer = SovrenRest::Employer.new(input['EmployerOrg'][0])
  end

  it 'should extract name' do
    expect(@employer.name).to eq(@name)
  end

  it 'should extract metadata' do
    expect(@employer.metadata).not_to be_nil
  end

  it 'should extract positions' do
    expect(@employer.positions).not_to be_empty
  end
end
