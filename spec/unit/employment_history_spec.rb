require 'employment_history.rb'

RSpec.describe SovrenRest::EmploymentHistory do
  context 'with all relevant information' do
    before :all do
      raw = File.read(File.expand_path('files/employment-history.json', __dir__))
      input = JSON.parse(raw)
      @employment_history = SovrenRest::EmploymentHistory.new(input)
    end

    it 'should extract an employer' do
      expect(@employment_history.employers).not_to be_empty
    end
  end
  context 'with missing information' do
    before :all do
      @employment_history = SovrenRest::EmploymentHistory.new({})
    end

    it 'should not extract an employer' do
      expect(@employment_history.employers).to be_empty
    end
  end
end
