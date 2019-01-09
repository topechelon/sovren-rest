require 'sovren-rest/contact_information.rb'

RSpec.describe SovrenRest::ContactInformation do
  context 'with all relevant information' do
    before :all do
      @first_name = 'Johan'
      @middle_name = 'Von'
      @last_name = 'Testingstonly'

      raw = File.read(File.expand_path('../files/contact-info.json', __dir__))
      input = JSON.parse(raw)
      @contact_info = SovrenRest::ContactInformation.new(input)
    end

    it 'should extract first_name' do
      expect(@contact_info.first_name).to eq(@first_name)
    end

    it 'should extract middle_name' do
      expect(@contact_info.middle_name).to eq(@middle_name)
    end

    it 'should extract last_name' do
      expect(@contact_info.last_name).to eq(@last_name)
    end

    it 'should extract email_addresses' do
      expect(@contact_info.email_addresses).not_to be_empty
    end

    it 'should extract websites' do
      expect(@contact_info.websites).not_to be_empty
    end

    it 'should extract phone_numbers' do
      expect(@contact_info.phone_numbers).not_to be_empty
    end

    it 'should extract addresses' do
      expect(@contact_info.addresses).not_to be_empty
    end
  end

  context 'with missing information' do
    before :all do
      @first_name = nil
      @middle_name = nil
      @last_name = nil
      @email_addresses = []
      @websites = []
      @phone_numbers = []
      @addresses = []
      @contact_info = SovrenRest::ContactInformation.new({})
    end

    it 'should handle missing first_name' do
      expect(@contact_info.first_name).to eq(@first_name)
    end

    it 'should handle missing middle_name' do
      expect(@contact_info.middle_name).to eq(@middle_name)
    end

    it 'should handle missing last_name' do
      expect(@contact_info.last_name).to eq(@last_name)
    end

    it 'should handle missing email_addresses' do
      expect(@contact_info.email_addresses).to eq(@email_addresses)
    end

    it 'should handle missing websites' do
      expect(@contact_info.websites).to eq(@websites)
    end

    it 'should handle missing phone_numbers' do
      expect(@contact_info.phone_numbers).to eq(@phone_numbers)
    end

    it 'should handle missing addresses' do
      expect(@contact_info.addresses).to eq(@addresses)
    end
  end
end
