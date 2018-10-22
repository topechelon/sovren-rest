module SovrenRest
  ##
  # Represents the client that executes calls against a remote host.
  class Client
    # Parse resume controller/action path.
    PARSE_RESUME = '/parser/resume'.freeze

    ##
    # Creates a new sovren rest client with the given options.
    #
    #   options =>
    #   {
    #     base_url      #  Endpoint to Sovren rest service
    #     account_id    #  Sovren account ID. If self hosted, not required
    #     service_key   #  Sovren service key. If self hosted, not required
    #     configuration #  Sovren parser configuration string. Optional
    #   }
    def initialize(options)
      @base_url = options[:base_url]
      @account_id = options[:account_id] || '12345678'
      @service_key = options[:service_key] || 'thiscanbeanything,whyrequireit?'
      @configuration = options[:configuration] || ''
    end

    ##
    # Parses a raw resume PDF file and returns a SovrenRest::Resume object.
    # Throws if Sovren does not return an Info.Code of 'Success'.
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

    private

    ##
    # Builds up header for remote calls.
    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Sovren-AccountId' => @account_id,
        'Sovren-ServiceKey' => @service_key
      }
    end

    ##
    # Builds up body of message for remote call.
    def body(input_file)
      {
        'DocumentAsBase64String' => Base64.encode64(input_file),
        'OutputHtml' => 'true',
        'Configuration' => @configuration
      }
    end

    ##
    # Helper methods to construct host/controller/action URL.
    def build_url(action)
      "#{@base_url}#{action}"
    end
  end
end
