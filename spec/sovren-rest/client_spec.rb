require 'client.rb'
require 'base64'
require 'rest-client'

RSpec.describe SovrenRest::Client do
  it 'should create #new' do
    expect(SovrenRest::Client).to receive(:new).with(
      accountId: '12345678',
      baseUrl: 'google.com',
      serviceKey: 'thiscanbeanything,whyrequireit?'
    )
    SovrenRest::Client.new(baseUrl: 'google.com', accountId: '12345678', serviceKey: 'thiscanbeanything,whyrequireit?')
  end

  it 'should call #parse and throw error' do
    client = SovrenRest::Client.new(baseUrl: 'google.com', accountId: '12345678', serviceKey: 'thiscanbeanything,whyrequireit?')
    expect { client.parse('rawFileContents') }.to raise_error RestClient::NotFound
  end

  it 'should call #parse_html and throw error' do
    client = SovrenRest::Client.new(baseUrl: 'google.com', accountId: '12345678', serviceKey: 'thiscanbeanything,whyrequireit?')
    expect { client.parse('rawFileContents') }.to raise_error RestClient::NotFound
  end
end
