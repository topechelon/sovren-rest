module SovrenRest
  ##
  # Represents the client that executes calls against a remote host.
  class Client
    # Parse resume controller/action path.
    PARSE_RESUME = '/parser/resume'.freeze

    # To prevent credits from being lost, RestClient should almost never kill a
    # Sovren parse request. This timeout is exceptionally high in order to try
    # to give Sovren all the time it needs to parse a file, no matter how slow.
    REQUEST_TIMEOUT_SECONDS = 300

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
    # Parses a raw resume PDF file and returns a SovrenRest::ParseResponse.
    # Throws an exception if the request is not successful
    def parse(raw_file)
      raw_response = RestClient::Request.execute(post_arguments(raw_file))
      SovrenRest::ParseResponse.new(raw_response.body)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e.response)
    end

    private

    def handle_error(raw_response)
      unless raw_response
        exception_args = [
          "Request timed out after #{REQUEST_TIMEOUT_SECONDS} seconds.",
          code: 'RestClientTimeout'
        ]
        raise SovrenRest::ParsingError.for(*exception_args)
      end

      response = SovrenRest::ParseResponse.new(raw_response.body)
      raise SovrenRest::ParsingError.for(response.message, code: response.code)
    end

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
    def parse_body(input_file)
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

    ##
    # Helper methods to build arguments
    def post_arguments(raw_file)
      {
        method: :post,
        url: build_url(PARSE_RESUME),
        payload: parse_body(raw_file).to_json,
        headers: headers,
        timeout: REQUEST_TIMEOUT_SECONDS
      }
    end
  end
end
