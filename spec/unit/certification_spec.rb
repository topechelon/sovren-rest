require 'certification.rb'

RSpec.describe SovrenRest::Certification do
  before :all do
    @name = 'Certified Stuff'
    @description = 'Certified to do stuff and things'
    @effective_date = '2018-10'

    raw = File.read(File.expand_path('files/certification.json', __dir__))
    input = JSON.parse(raw)

    @certification = SovrenRest::Certification.new(input)
  end

  it 'should extract name' do
    expect(@certification.name).to eq(@name)
  end

  it 'should extract description' do
    expect(@certification.description).to eq(@description)
  end

  it 'should extract effective_date' do
    expect(@certification.effective_date).to eq(@effective_date)
  end
end