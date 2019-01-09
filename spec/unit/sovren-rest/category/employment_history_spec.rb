require 'sovren-rest/category/employment_history.rb'

RSpec.describe SovrenRest::Category::EmploymentHistory do
  context 'with all relevant information' do
    before :all do
      @company_name = 'Stuff N\' Things'

      raw = File.read(File.expand_path('../../files/employment-history.json', __dir__))
      input = JSON.parse(raw)
      @employer = SovrenRest::Category::EmploymentHistory.new(input['EmployerOrg'][0])
    end

    it 'should extract company_name' do
      expect(@employer.company_name).to eq(@company_name)
    end

    it 'should extract metadata' do
      expect(@employer.metadata).not_to be_nil
    end

    it 'should extract employment_positions' do
      expect(@employer.employment_positions).not_to be_empty
    end
  end

  context 'with missing information' do
    before :all do
      @company_name = nil

      @employer = SovrenRest::Category::EmploymentHistory.new({})
    end

    it 'should extract company_name' do
      expect(@employer.company_name).to eq(@company_name)
    end

    it 'should extract metadata' do
      expect(@employer.metadata).to be_nil
    end

    it 'should extract employment_positions' do
      expect(@employer.employment_positions).to be_empty
    end
  end
end
