require 'sovren-rest/parse_response.rb'
require 'sovren-rest/client.rb'
require 'sovren-rest/exceptions.rb'
require 'base64'
require 'rest-client'

RSpec.describe SovrenRest::Client do
  let(:client) { SovrenRest::Client.new(base_url: '1.1.1.1/sovren') }
  let(:default_account_id) { '12345678' }
  let(:default_service_key) { 'thiscanbeanything,whyrequireit?' }
  let(:default_configuration) { '' }

  describe 'initialization' do
    it 'defaults the account ID if not specified' do
      expect(client.instance_variable_get(:@account_id)).to eq(default_account_id)
    end

    it 'defaults the service key if not specified' do
      expect(client.instance_variable_get(:@service_key)).to eq(default_service_key)
    end

    it 'defaults the configuration if not specified' do
      expect(client.instance_variable_get(:@configuration)).to eq(default_configuration)
    end
  end

  describe 'parse' do
    let(:raw_post_response_body) { '{"Info":{"Code":"Success", "Message":"Success"}, "Value":{}}' }
    let(:post_response) { instance_double('RestClient::Response') }
    let(:response) { SovrenRest::ParseResponse.new(raw_post_response_body) }
    let(:input_file) { 'content' }
    let(:expected_body) do
      {
        'DocumentAsBase64String' => Base64.encode64(input_file),
        'OutputHtml' => 'true',
        'Configuration' => default_configuration
      }.to_json
    end
    let(:expected_headers) do
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Sovren-AccountId' => default_account_id,
        'Sovren-ServiceKey' => default_service_key
      }
    end
    let(:expected_arguments) do
      [
        '1.1.1.1/sovren/parser/resume',
        expected_body,
        expected_headers
      ]
    end

    before do
      allow(RestClient).to receive(:post).with(*expected_arguments).and_return(post_response)
      allow(post_response).to receive(:body).and_return(raw_post_response_body)
      allow(SovrenRest::ParseResponse).to receive(:new).with(raw_post_response_body).and_return(response)
    end

    it 'POSTS to sovren with the encoded file' do
      expect(RestClient).to receive(:post).with(*expected_arguments).and_return(post_response)
      client.parse(input_file)
    end

    context 'successful post' do
      it 'initializes a SovrenRest::ParseResponse' do
        expect(SovrenRest::ParseResponse).to receive(:new).with(raw_post_response_body).and_return(response)
        client.parse(input_file)
      end

      context 'and the code is success' do
        it 'returns the response' do
          expect(client.parse(input_file)).to eq(response)
        end
      end

      context 'and the code is not success' do
        let(:error_code) { 'ConversionException' }
        let(:error_message) { 'Could not convert document' }
        let(:raw_post_response_body) { "{\"Info\":{\"Code\":\"#{error_code}\", \"Message\":\"#{error_message}\"}, \"Value\":{}}" }

        it 'raises a SovrenRest::ParsingError' do
          expect { client.parse(input_file) }.to raise_error(SovrenRest::ParsingError)
        end

        it 'sets the sovren code on the exception' do
          expect { client.parse(input_file) }.to raise_error do |error|
            expect(error.code).to eq(error_code)
          end
        end

        it 'adds the sovren response message to the error message' do
          expect { client.parse(input_file) }.to raise_error do |error|
            expect(error.message).to eq(error_message)
          end
        end
      end
    end

    context 'unsuccessful post' do
      let(:error_code) { 'ConversionException' }
      let(:error_message) { 'Failed to convert document - ovNoText' }
      let(:raw_post_response_body) { "{\"Info\":{\"Code\":\"#{error_code}\", \"Message\":\"#{error_message}\"}, \"Value\":{}}" }

      before { allow(RestClient).to receive(:post).with(*expected_arguments).and_raise(RestClient::InternalServerError.new(post_response)) }

      it 're-raises a SovrenRest::ParsingError' do
        expect { client.parse(input_file) }.to raise_error(SovrenRest::ParsingError)
      end

      it 'sets the sovren code on the exception' do
        expect { client.parse(input_file) }.to raise_error do |error|
          expect(error.code).to eq(error_code)
        end
      end

      it 'adds the sovren response message to the error message' do
        expect { client.parse(input_file) }.to raise_error do |error|
          expect(error.message).to eq(error_message)
        end
      end
    end
  end
end
