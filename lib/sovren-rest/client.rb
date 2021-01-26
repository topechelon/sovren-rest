# frozen_string_literal: true

module SovrenRest
  ##
  # Represents the client that executes calls against a remote host.
  class Client
    # Parse resume controller/action path.
    PARSE_RESUME = '/parser/resume'

    # To prevent credits from being lost, RestClient should almost never kill a
    # Sovren parse request. This timeout is exceptionally high in order to try
    # to give Sovren all the time it needs to parse a file, no matter how slow.
    REQUEST_TIMEOUT_SECONDS = 300
    HTTP_GATEWAY_TIMEOUT = 504

    ##
    # Creates a new sovren rest client with the given options.
    #
    #   options =>
    #   {
    #     base_url                          #  Endpoint to Sovren rest service
    #     account_id                        #  Sovren account ID. If self hosted, not required
    #     service_key                       #  Sovren service key. If self hosted, not required
    #     configuration                     #  Sovren parser configuration string. Optional
    #     additional_parse_request_headers  #  Additional headers for the remote call. Optional
    #   }
    def initialize(options)
      @base_url = options[:base_url]
      @account_id = options[:account_id] || '12345678'
      @service_key = options[:service_key] || 'thiscanbeanything,whyrequireit?'
      @configuration = options[:configuration] || ''
      @additional_parse_request_headers = options[:additional_parse_request_headers] || {}
    end

    ##
    # Parses a raw resume PDF file and returns a SovrenRest::ParseResponse.
    # Throws an exception if the request is not successful
    def parse(raw_file, filemeta: {})
      response = RestClient::Request.execute(post_arguments(raw_file, filemeta))
      SovrenRest::ParseResponse.new(response.body)
    rescue RestClient::Exceptions::Timeout
      raise SovrenRest::ClientException::RestClientTimeout
    rescue RestClient::ExceptionWithResponse => e
      handle_response_error(e.response)
    end

    private

    def handle_response_error(rest_client_response)
      raise SovrenRest::ClientException::GatewayTimeout if gateway_timeout?(rest_client_response)

      response = SovrenRest::ParseResponse.new(rest_client_response.body)
      raise SovrenRest::ParsingError.for(response.message, code: response.code)
    end

    def gateway_timeout?(rest_client_response)
      return false unless rest_client_response.code == HTTP_GATEWAY_TIMEOUT

      rest_client_response.body =~ /504 Gateway Time-out/
    end

    ##
    # Builds up header for remote calls.
    def headers
      base_headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Sovren-AccountId' => @account_id,
        'Sovren-ServiceKey' => @service_key
      }

      @additional_parse_request_headers.merge(base_headers)
    end

    ##
    # Builds up body of message for remote call.
    def parse_body(input_file, filemeta)
      body = {
        'DocumentAsBase64String' => Base64.encode64(input_file),
        'OutputHtml' => 'true',
        'Configuration' => @configuration
      }

      body['RevisionDate'] = format_timestamp(filemeta.delete(:revision_date)) if filemeta.key?(:revision_date)

      body
    end

    def format_timestamp(date)
      return if date.nil?

      # Sovren requires date to be in YYYY-MM-DD format
      # https://docs.sovren.com/API/Rest/Parsing#parse-resume
      return date.strftime('%Y-%m-%d') if date.respond_to?(:strftime)

      raise "Unsupported Date Type - #{date.inspect}"
    end

    ##
    # Helper methods to construct host/controller/action URL.
    def build_url(action)
      "#{@base_url}#{action}"
    end

    ##
    # Helper methods to build arguments
    def post_arguments(raw_file, filemeta)
      {
        method: :post,
        url: build_url(PARSE_RESUME),
        payload: parse_body(raw_file, filemeta).to_json,
        headers: headers,
        timeout: REQUEST_TIMEOUT_SECONDS
      }
    end
  end
end
