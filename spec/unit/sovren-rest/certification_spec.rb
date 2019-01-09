require 'sovren-rest/certification.rb'

RSpec.describe SovrenRest::Certification do
  context 'with all relevant information' do
    before :all do
      @name = 'Certified Stuff'
      @description = 'Certified to do stuff and things'

      raw = File.read(File.expand_path('../files/certification.json', __dir__))
      input = JSON.parse(raw)

      @certification = SovrenRest::Certification.new(input)
    end

    it 'should extract name' do
      expect(@certification.name).to eq(@name)
    end

    it 'should extract description' do
      expect(@certification.description).to eq(@description)
    end

    it 'should extract effective_dates' do
      expect(@certification.effective_dates).not_to be_empty
    end
  end
  context 'with missing information' do
    before :all do
      @name = nil
      @description = nil

      @certification = SovrenRest::Certification.new({})
    end

    it 'should handle missing name' do
      expect(@certification.name).to eq(@name)
    end

    it 'should handle missing description' do
      expect(@certification.description).to eq(@description)
    end

    it 'should handle missing effective_dates' do
      expect(@certification.effective_dates).to be_empty
    end
  end
end
