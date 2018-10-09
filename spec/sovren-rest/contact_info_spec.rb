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
    @address_line1 = '123 Test St'
    @address_line2 = 'APT # 123'
    @city = 'North Canton'
    @state = 'Ohio'
    @country = 'US'
    @postal_code = '44720'

    raw = File.read(File.expand_path('files/contact-info.json', __dir__))
    input = JSON.parse(raw)
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

  it 'should extract address_line1' do
    expect(@contact_info.address_line1).to eq(@address_line1)
  end

  it 'should extract address_line2' do
    expect(@contact_info.address_line2).to eq(@address_line2)
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
