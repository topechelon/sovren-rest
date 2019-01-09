require 'sovren-rest/education_history.rb'

RSpec.describe SovrenRest::EducationHistory do
  context 'with all relevant information' do
    before :all do
      @school_name = 'University of Stuff'
      @degree_type = 'masters'
      @degree_major = 'Stuff N Things'
      @end_date = '2016-08'
      @graduated = 'false'

      raw = File.read(File.expand_path('../files/education-history.json', __dir__))
      input = JSON.parse(raw)
      @education = SovrenRest::EducationHistory.new(input['SchoolOrInstitution'][0])
    end

    it 'should extract school_name' do
      expect(@education.school_name).to eq(@school_name)
    end

    it 'should extract degree_type' do
      expect(@education.degree_type).to eq(@degree_type)
    end

    it 'should extract degree_major' do
      expect(@education.degree_major).to eq(@degree_major)
    end

    it 'should extract graduated' do
      expect(@education.graduated).to eq(@graduated)
    end

    it 'should extract end_date' do
      expect(@education.end_date).to eq(@end_date)
    end
  end
  context 'with missing information' do
    before :all do
      @school_name = nil
      @degree_type = nil
      @degree_major = nil
      @end_date = nil
      @graduated = nil

      @education = SovrenRest::EducationHistory.new({})
    end

    it 'should handle missing school_name' do
      expect(@education.school_name).to eq(@school_name)
    end

    it 'should handle missing degree_type' do
      expect(@education.degree_type).to eq(@degree_type)
    end

    it 'should handle missing degree_major' do
      expect(@education.degree_major).to eq(@degree_major)
    end

    it 'should handle missing graduated' do
      expect(@education.graduated).to eq(@graduated)
    end

    it 'should handle missing end_date' do
      expect(@education.end_date).to eq(@end_date)
    end
  end
end
