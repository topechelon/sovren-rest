require 'experience_summary.rb'

RSpec.describe SovrenRest::ExperienceSummary do
  before :all do
    @months_experience = 81
    @years_experience = (@months_experience / 12).floor
    raw = File.read(File.expand_path('files/experience-summary.json', __dir__))
    input = JSON.parse(raw)
    @experience_summary = SovrenRest::ExperienceSummary.new(input)
  end

  it 'should extract months_of_work_experience' do
    expect(@experience_summary.months_of_work_experience).to eq(@months_experience)
  end

  it 'should calculate correct years_of_work_experience' do
    expect(@experience_summary.years_of_work_experience).to eq(@years_experience)
  end
end
