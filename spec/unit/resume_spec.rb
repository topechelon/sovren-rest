require 'resume.rb'

RSpec.describe SovrenRest::Resume do
  context 'with all relevant information' do
    before :all do
      ci_raw = File.read(File.expand_path('files/contact-info.json', __dir__))
      ci = JSON.parse(ci_raw)
      @contact_information = SovrenRest::ContactInformation.new(ci)

      emp_hist_raw = File.read(File.expand_path('files/employment-history.json', __dir__))
      emp_hist = JSON.parse(emp_hist_raw)
      @employment_history = emp_hist['EmployerOrg'].map { |wh| SovrenRest::EmploymentHistory.new(wh) }

      edu_hist_raw = File.read(File.expand_path('files/education-history.json', __dir__))
      edu_hist = JSON.parse(edu_hist_raw)
      @education_history = edu_hist['SchoolOrInstitution'].map { |eh| SovrenRest::EducationHistory.new(eh) }

      response_body = File.read(File.expand_path('files/resume.json', __dir__))
      @resume = SovrenRest::Resume.new(response_body)
    end

    it 'should parse contact_information' do
      expect(@resume.contact_information).to eql(@contact_information)
    end

    it 'should parse employment_history' do
      @resume.employment_history.each_with_index do |wh, idx|
        expect(wh).to eql(@employment_history[idx])
      end
    end

    it 'should parse education_history' do
      @resume.education_history.each_with_index do |eh, idx|
        expect(eh).to eql(@education_history[idx])
      end
    end
  end
  context 'with missing information' do
    before :all do
      @contact_information = SovrenRest::ContactInformation.new({})
      @resume = SovrenRest::Resume.new('{ "Value": null }')
    end

    it 'should parse contact_information' do
      expect(@resume.contact_information).to eql(@contact_information)
    end

    it 'should parse employment_history' do
      expect(@resume.employment_history).to be_empty
    end

    it 'should parse education_history' do
      expect(@resume.education_history).to be_empty
    end
  end
end
