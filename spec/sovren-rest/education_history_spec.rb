require 'education_history.rb'

RSpec.describe SovrenRest::EducationHistory do
  before :all do
    @school_name = 'University of Stuff'
    @degree_type = 'masters'
    @major = 'Stuff N Things'
    @end_date = '2016-08'
    @graduated = 'false'

    raw = File.read(File.expand_path('files/education-history.json', __dir__))
    input = JSON.parse(raw)
    @education = SovrenRest::EducationHistory.new(input['SchoolOrInstitution'][0])
  end

  it 'should extract school_name' do
    expect(@education.school_name).to eq(@school_name)
  end

  it 'should extract degree_type' do
    expect(@education.degree_type).to eq(@degree_type)
  end

  it 'should extract major' do
    expect(@education.major).to eq(@major)
  end

  it 'should extract graduated' do
    expect(@education.graduated).to eq(@graduated)
  end

  it 'should extract end_date' do
    expect(@education.end_date).to eq(@end_date)
  end
end
