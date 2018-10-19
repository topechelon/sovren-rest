require 'position_category.rb'

RSpec.describe SovrenRest::PositionCategory do
  before :all do
    @city = 'Canton'
    @state = 'Ohio'
    @country = 'US'

    raw = File.read(File.expand_path('files/employment-history.json', __dir__))
    input = JSON.parse(raw).dig('EmployerOrg', 0, 'PositionHistory', 0, 'UserArea')
    @category = SovrenRest::PositionCategory.new(input)
  end

  it 'should extract data' do
    expect(@category.data).not_to be_nil
  end
end
