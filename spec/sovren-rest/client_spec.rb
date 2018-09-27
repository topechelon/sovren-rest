require 'client.rb'
require 'base64'
require 'rest-client'

RSpec.describe SovrenRest::Client do
  it 'should create new client' do
    expect(SovrenRest::Client).to receive(:new).with(
      {
        :account_id=>"12345678",
        :base_url=>"google.com",
        :service_key=>"thiscanbeanything,whyrequireit?"
      }
    )
    SovrenRest::Client.new(base_url: 'google.com', account_id: '12345678', service_key: 'thiscanbeanything,whyrequireit?')
  end

  it 'should call parse and throw error' do
    client = SovrenRest::Client.new(base_url: 'google.com', account_id: '12345678', service_key: 'thiscanbeanything,whyrequireit?')
    expect{client.parse('rawFileContents')}.to raise_error RestClient::NotFound
  end
end