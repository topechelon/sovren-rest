require 'sovren-rest'

RSpec.describe 'SovrenRest::Integration::ClientParse' do
  before :all do
    unless ENV.key?('SOVREN_HOST')
      raise 'Environment variable \'SOVREN_HOST\' is missing'
    end

    @host = ENV.fetch('SOVREN_HOST')
    @config = ENV.fetch('SOVREN_CFG', '')
    @file = File.read(File.expand_path('../files/resume.pdf', __dir__))
    @client = SovrenRest::Client.new(base_url: @host, configuration: @config)
  end

  it 'should parse a resume successfully' do
    @client.parse(@file)
  end
end
