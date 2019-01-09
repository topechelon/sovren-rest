require 'sovren-rest/employment_position.rb'

RSpec.describe SovrenRest::EmploymentPosition do
  context 'with all relevant information' do
    before :all do
      @current = 'true'
      @title = 'Senior Stuff Thinger'
      @department = 'Stuff N\' Things'
      @start_date = '2018-05'
      @end_date = 'current'
      @city = 'Canton'
      @state = 'Ohio'
      @country = 'US'

      raw = File.read(File.expand_path('../files/employment-history.json', __dir__))
      input = JSON.parse(raw).dig('EmployerOrg', 0, 'PositionHistory', 0)
      @position = SovrenRest::EmploymentPosition.new(input)
    end

    it 'should extract current' do
      expect(@position.current).to eq(@current)
    end

    it 'should extract title' do
      expect(@position.title).to eq(@title)
    end

    it 'should extract department' do
      expect(@position.department).to eq(@department)
    end

    it 'should extract start_date' do
      expect(@position.start_date).to eq(@start_date)
    end

    it 'should extract end_date' do
      expect(@position.end_date).to eq(@end_date)
    end

    it 'should extract description' do
      expect(@position.description).not_to be_nil
    end

    it 'should extract category' do
      expect(@position.categories).not_to be_nil
    end

    it 'should extract metadata' do
      expect(@position.metadata).not_to be_nil
    end

    it 'should extract city' do
      expect(@position.city).to eq(@city)
    end

    it 'should extract state' do
      expect(@position.state).to eq(@state)
    end

    it 'should extract country' do
      expect(@position.country).to eq(@country)
    end
  end
  context 'with missing information' do
    before :all do
      @current = false
      @department = nil
      @start_date = nil
      @end_date = 'current'
      @city = nil
      @state = nil
      @country = nil

      @position = SovrenRest::EmploymentPosition.new({})
    end

    it 'should extract current' do
      expect(@position.current).to eq(@current)
    end

    it 'should extract title' do
      expect(@position.title).to be_nil
    end

    it 'should extract department' do
      expect(@position.department).to eq(@department)
    end

    it 'should extract start_date' do
      expect(@position.start_date).to eq(@start_date)
    end

    it 'should extract end_date' do
      expect(@position.end_date).to eq(@end_date)
    end

    it 'should extract description' do
      expect(@position.description).to be_nil
    end

    it 'should extract category' do
      expect(@position.categories).to be_empty
    end

    it 'should extract metadata' do
      expect(@position.metadata).to be_nil
    end

    it 'should extract city' do
      expect(@position.city).to eq(@city)
    end

    it 'should extract state' do
      expect(@position.state).to eq(@state)
    end

    it 'should extract country' do
      expect(@position.country).to eq(@country)
    end
  end
end
