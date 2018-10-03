require 'contact_info.rb'

RSpec.describe SovrenRest::ContactInfo do
  before :all do
    @first_name = 'Johan'
    @middle_name = 'Von'
    @last_name = 'Testingstonly'
    @email_addresses =
      [
        'jtestingstonly@gmail.com'
      ]
    @websites =
      [
        'https://github.com/jtestingstonly',
        'https://www.linkedin.com/in/jtestingstonly'
      ]
    @phone_numbers =
      [
        '330-867-5309'
      ]
    @address_line_1 = '123 Test St'
    @address_line_2 = 'APT # 123'
    @city = 'North Canton'
    @state = 'Ohio'
    @country = 'US'
    @postal_code = '44720'

    input =
      {
        'PersonName' =>
        {
          'FormattedName' => "#{@first_name} #{@middle_name} #{@last_name}",
          'GivenName' => @first_name,
          'MiddleName' => @middle_name,
          'FamilyName' => @last_name
        },
        'ContactMethod' =>
        [
          {
            'WhenAvailable' => 'anytime',
            'PostalAddress' =>
            {
              'CountryCode' => @country,
              'PostalCode' => @postal_code,
              'Region' => [@state],
              'Municipality' => @city,
              'DeliveryAddress' =>
              {
                'AddressLine' =>
                [
                  @address_line_1,
                  @address_line_2
                ]
              }
            }
          },
          {
            'Telephone' =>
            {
              'FormattedNumber' => @phone_numbers[0]
            }
          },
          {
            'Use' => 'personal',
            'Location' => 'onPerson',
            'WhenAvailable' => 'anytime',
            'InternetEmailAddress' => @email_addresses[0]
          },
          {
            'Use' => 'businessDirect',
            'Location' => 'onPerson',
            'WhenAvailable' => 'anytime',
            'InternetWebAddress' => @websites[0]
          },
          {
            'Use' => 'businessDirect',
            'Location' => 'onPerson',
            'WhenAvailable' => 'anytime',
            'InternetWebAddress' => @websites[1]
          }
        ]
      }
    @contact_info = SovrenRest::ContactInfo.new(input)
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
    expect(@contact_info.email_addresses).to eq(@email_addresses)
  end

  it 'should extract websites' do
    expect(@contact_info.websites).to eq(@websites)
  end

  it 'should extract phone_numbers' do
    expect(@contact_info.phone_numbers).to eq(@phone_numbers)
  end

  it 'should extract address_line_1' do
    expect(@contact_info.address_line_1).to eq(@address_line_1)
  end

  it 'should extract address_line_2' do
    expect(@contact_info.address_line_2).to eq(@address_line_2)
  end

  it 'should extract city' do
    expect(@contact_info.city).to eq(@city)
  end

  it 'should extract state' do
    expect(@contact_info.state).to eq(@state)
  end

  it 'should extract country' do
    expect(@contact_info.country).to eq(@country)
  end

  it 'should extract postal_code' do
    expect(@contact_info.postal_code).to eq(@postal_code)
  end
end
