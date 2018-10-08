require 'experience_summary.rb'

RSpec.describe SovrenRest::ExperienceSummary do
  before :all do
    @months_experience = 81
    @years_experience = (@months_experience / 12).floor
    input =
      {
        'sov:Description': 'Johan Von Testingstonly\'s experience appears to be strongly concentrated in Information Technology (mostly Programming), and slightly concentrated in Engineering (mostly Other).',
        'sov:MonthsOfWorkExperience': @months_experience.to_s,
        'sov:AverageMonthsPerEmployer': '27',
        'sov:FulltimeDirectHirePredictiveIndex': '85',
        'sov:MonthsOfManagementExperience': '0',
        'sov:HighestManagementScore': '0',
        'sov:ExecutiveType': 'none',
        'sov:ManagementStory': nil
      }
    @experience_summary = SovrenRest::ExperienceSummary.new(input)
  end

  it 'should extract number of months experience' do
    expect(@experience_summary.months_of_work_experience).to eq(@months_experience)
  end

  it 'should calculate correct number of years experience' do
    expect(@experience_summary.years_of_work_experience).to eq(@years_experience)
  end
end
