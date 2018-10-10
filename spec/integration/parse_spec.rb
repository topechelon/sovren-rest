require 'rest-client'
require 'base64'
require 'json'
require 'client.rb'
require 'resume.rb'
require 'contact_info.rb'
require 'education_history.rb'
require 'employment_history.rb'
require 'experience_summary.rb'

RSpec.describe 'SovrenRest::Integration::ClientParse' do
  before :all do
    unless ENV.key?('SOVREN_HOST')
      raise 'Environment variable \'SOVREN_HOST\' is missing'
    end

    @host = ENV['SOVREN_HOST']
    @config = ENV.fetch('SOVREN_HOST')
    @file = File.read(File.expand_path('files/resume.pdf', __dir__))
    @client = SovrenRest::Client.new(baseUrl: @host, configuration: @config)
  end

  it 'should parse a resume' do
    resume = @client.parse(@file)
    puts "host: #{@host}\nclient: #{@client}\nresume: #{resume.inspect}"
  end
end
