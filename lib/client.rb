module SovrenRest
  # Represents the client that executes calls against the remote host.
  class Client
    PARSE_RESUME = '/parser/resume'.freeze
    def initialize(options = {})
      @base_url = options[:base_url]
      @account_id = options[:account_id] || '12345678'
      @service_key = options[:service_key] || 'thiscanbeanything,whyrequireit?'
      @configuration = options[:configuration] || ''
    end

    def parse(raw_file)
      endpoint = build_url(PARSE_RESUME)
      response = RestClient
                 .post(endpoint, body(raw_file).to_json, headers).body

      status = JSON.parse(response)['Info']

      if status['Code'] != 'Success'
        raise "Resume parsing error:\n#{status['Message']}"
      end

      SovrenRest::Resume.new(response)
    end

    def convert_to_html(raw_file)
      parse(raw_file).html
    end

    private

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Sovren-AccountId' => @account_id,
        'Sovren-ServiceKey' => @service_key
      }
    end

    def body(input_file)
      {
        'DocumentAsBase64String' => Base64.encode64(input_file),
        'OutputHtml' => 'true',
        'Configuration' => @configuration
      }
    end

    def build_url(action)
      "#{@base_url}#{action}"
    end
  end
end
