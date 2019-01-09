require 'sovren-rest/parse_response.rb'

RSpec.describe SovrenRest::ParseResponse do
  let(:file_content) { File.read(File.expand_path('../files/response.json', __dir__)) }
  let(:parse_response) { SovrenRest::ParseResponse.new(file_content) }

  describe 'html' do
    subject { parse_response.html }
    it { is_expected.to eq 'HTML Content' }
  end

  shared_examples_for :resume do |method_name, key|
    describe method_name.to_s do
      subject { parse_response.send(method_name) }
      it { is_expected.to be_a SovrenRest::Resume }

      it "uses the data from #{key}" do
        data = JSON.parse(JSON.parse(file_content).dig('Value', key))
        expect(subject.data).to eq data
      end
    end
  end

  include_examples :resume, :parsed_resume, 'ParsedDocument'
  include_examples :resume, :scrubbed_parsed_resume, 'ScrubbedParsedDocument'

  describe 'successful?' do
    context 'when the status code is \'Success\'' do
      subject { parse_response }
      before { parse_response.send(:info)['Code'] = 'Success' }
      it { is_expected.to be_successful }
    end
  end
end
