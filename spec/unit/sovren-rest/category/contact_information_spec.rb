require 'sovren-rest.rb'

RSpec.describe SovrenRest::Category::ContactInformation do
  context 'with all relevant information' do
    before :all do
      @first_name = 'Johan'
      @middle_name = 'Von'
      @last_name = 'Testingstonly'
      @formatted_name = 'Johan Von Testingstonly, III'
      @phone_numbers = [
        { 'Telephone' => { 'FormattedNumber' => '330-867-5309' } },
        { 'Mobile' => { 'FormattedNumber' => '555-555-5555' } }
      ]
      @email_addresses = [
        { 'Use' => 'personal', 'Location' => 'onPerson', 'WhenAvailable' => 'anytime', 'InternetEmailAddress' => 'jtestingstonly@gmail.com' }
      ]
      @websites = [
        {
          'Use' => 'businessDirect',
          'Location' => 'onPerson',
          'WhenAvailable' => 'anytime',
          'InternetWebAddress' => 'https://github.com/jtestingstonly'
        },
        {
          'Use' => 'businessDirect',
          'Location' => 'onPerson',
          'WhenAvailable' => 'anytime',
          'InternetWebAddress' => 'https://www.linkedin.com/in/jtestingstonly'
        }
      ]
      @addresses = [
        {
          'WhenAvailable' => 'anytime',
          'PostalAddress' => {
            'CountryCode' => 'US',
            'PostalCode' => '44720',
            'Region' => [
              'Ohio'
            ],
            'Municipality' => 'North Canton',
            'DeliveryAddress' => {
              'AddressLine' => [
                '123 Test St',
                'APT # 123'
              ]
            }
          }
        }
      ]

      raw = File.read(File.expand_path('../../files/contact-info.json', __dir__))
      input = JSON.parse(raw)
      @contact_info = SovrenRest::Category::ContactInformation.new(input)
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

    it 'should extract formatted_name' do
      expect(@contact_info.formatted_name).to eq(@formatted_name)
    end

    it 'should extract full_name' do
      expect(@contact_info.full_name).to eq('Johan Von Testingstonly')
    end

    it 'should extract email_addresses' do
      expect(@contact_info.email_addresses).to eq(@email_addresses)
    end

    it 'should extract websites' do
      expect(@contact_info.websites).to eq(@websites)
    end

    it 'should extract phone_numbers' do
      expect(@contact_info.phone_numbers).to eq(@phone_numbers)
    end

    it 'should extract addresses' do
      expect(@contact_info.addresses).to eq(@addresses)
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
      @contact_info = SovrenRest::Category::ContactInformation.new({})
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

    context 'full_name' do
      context 'with nil values' do
        before :each do
          @contact_info.instance_variable_set(:@data, 'PersonName' => { 'GivenName' => 'Test', 'FamilyName' => 'Person', 'MiddleName' => nil })
        end

        it 'ignores the missing information' do
          expect(@contact_info.full_name).to eq('Test Person')
        end
      end

      context 'with blank values' do
        before :each do
          @contact_info.instance_variable_set(:@data, 'PersonName' => { 'GivenName' => 'Test', 'FamilyName' => '      ', 'MiddleName' => 'A' })
        end

        it 'ignores the missing information' do
          expect(@contact_info.full_name).to eq('Test A')
        end
      end
    end
  end
end
