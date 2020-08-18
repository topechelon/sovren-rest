require 'sovren-rest.rb'
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
    let(:rest_client_response) { instance_double('RestClient::Response') }
    let(:parse_response) { SovrenRest::ParseResponse.new(raw_post_response_body) }
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
      {
        method: :post,
        url: '1.1.1.1/sovren/parser/resume',
        payload: expected_body,
        headers: expected_headers,
        timeout: 300
      }
    end
    let(:http_code) { 400 }
    let(:parse_arguments) { [input_file] }

    subject { client.parse(*parse_arguments) }

    before do
      allow(RestClient::Request).to receive(:execute).with(expected_arguments).and_return(rest_client_response)
      allow(rest_client_response).to receive(:body).and_return(raw_post_response_body)
      allow(rest_client_response).to receive(:code).and_return(http_code)
      allow(SovrenRest::ParseResponse).to receive(:new).with(raw_post_response_body).and_return(parse_response)
    end

    it 'POSTS to sovren with the encoded file' do
      expect(RestClient::Request).to receive(:execute).with(expected_arguments).and_return(rest_client_response)
      subject
    end

    context 'successful post' do
      it 'initializes a SovrenRest::ParseResponse' do
        expect(SovrenRest::ParseResponse).to receive(:new).with(raw_post_response_body).and_return(parse_response)
        subject
      end

      it 'returns the parse_response' do
        expect(subject).to eq(parse_response)
      end
    end

    context 'when revision_date file meta is given' do
      let(:revision_date) { Time.at(1_590_000_000) } # 2020-05-20 14:40:00 -0400
      let(:parse_arguments) { [input_file, filemeta: { revision_date: revision_date }] }

      let(:expected_body) do
        {
          'DocumentAsBase64String' => Base64.encode64(input_file),
          'OutputHtml' => 'true',
          'Configuration' => default_configuration,
          'RevisionDate' => '2020-05-20'
        }.to_json
      end

      it 'includes RevisionDate in the request' do
        expect(subject).to eq(parse_response)
      end

      context 'when revision_date is an unsupported type' do
        let(:revision_date) { '2020-05-20' }

        it 'raises an exception' do
          expect do
            subject
          end.to raise_error('Unsupported Date Type - "2020-05-20"')
        end
      end
    end

    context 'unsuccessful post' do
      shared_examples_for :error_scenario do |error_code, error_message, error_class|
        context "when a #{error_code} error is returned" do
          let(:raw_post_response_body) { { 'Info' => { 'Code' => error_code, 'Message' => error_message }, 'Value' => {} }.to_json }

          before { allow(RestClient::Request).to receive(:execute).with(expected_arguments).and_raise(RestClient::InternalServerError.new(rest_client_response)) }

          it "re-raises a #{error_class.name}" do
            expect { subject }.to raise_error(error_class)
          end

          it 'sets the sovren code on the exception' do
            expect { subject }.to raise_error do |error|
              expect(error.code).to eq(error_code)
            end
          end

          it 'adds the sovren parse_response message to the error message' do
            expect { subject }.to raise_error do |error|
              expect(error.message).to eq(error_message)
            end
          end
        end
      end

      SovrenRest::ERROR_CODE_CLASSES.each do |code, error_class|
        include_examples :error_scenario, code, '', error_class
      end

      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovNoText): No usable text was able to be extracted.', SovrenRest::ConversionNoTextException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovTimeout): The timeout was reached during conversion.', SovrenRest::ConversionTimeoutException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovIsImage): The document is just an image file. You will need to OCR the file to extract the text.', SovrenRest::ConversionImageException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovCorrupt): The input document was recognized but is either corrupt or cannot be converted because the details of the file cannot be understood.', SovrenRest::ConversionCorruptException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovUnsupportedFormat): We encountered an input/output format combination that we cannot convert with the current converters, using the subset that you enabled using the EnabledModules property.', SovrenRest::ConversionUnsupportedFormatException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovIsEncrypted): The document is encrypted and cannot be opened except using a password, which we obviously do not have!', SovrenRest::ConversionEncryptedException
      include_examples :error_scenario, 'ConversionException', 'Possible document conversion issues (ovErrorOnOutputToText): An internal exception occurred while converting to TEXT.Enable //Trace listener for //TraceSource named "DocumentConverter" to capture details about the error.', SovrenRest::ConversionToOutputTextException
      include_examples :error_scenario, 'ConversionException', 'ovSomethingElse', SovrenRest::ConversionException
      include_examples :error_scenario, 'foo', 'ovSomethingElse', SovrenRest::ParsingError

      context 'misc exceptions' do
        context 'when RestClient::Exceptions::Timeout is raised' do
          before do
            allow(RestClient::Request).to receive(:execute).with(expected_arguments).and_raise(RestClient::Exceptions::Timeout)
          end

          it 'raises a SovrenRest::ClientException::RestClientTimeout exception' do
            expect { subject }.to raise_error(SovrenRest::ClientException::RestClientTimeout)
          end
        end

        context 'when 504 Gateway Time-out is received' do
          let(:gateway_timeout_html) do
            <<-HTML
              <html>
                <head>
                  <title>504 Gateway Time-out</title>
                </head>
                <body>
                  <center>
                    <h1>504 Gateway Time-out</h1>
                  </center>
                </body>
              </html>
            HTML
          end
          let(:http_code) { 504 }

          before do
            allow(RestClient::Request).to receive(:execute).with(expected_arguments).and_raise(RestClient::InternalServerError.new(rest_client_response))
            allow(rest_client_response).to receive(:body).and_return(gateway_timeout_html)
          end

          it 'raises a SovrenRest::ClientException::GatewayTimeout exception' do
            expect { subject }.to raise_error(SovrenRest::ClientException::GatewayTimeout)
          end
        end
      end
    end
  end
end
