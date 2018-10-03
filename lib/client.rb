require 'base64'
require 'json'

module SovrenRest
  # Represents the client that executes calls against the remote host.
  class Client
    PARSE_RESUME = '/parser/resume'.freeze
    def initialize(options = {})
      @base_url = options[:baseUrl]
      @account_id = options[:accountId] || '12345678'
      @service_key = options[:serviceKey] || 'thiscanbeanything,whyrequireit?'
      @configuration = options[:configuration] || ''
    end

    def parse(raw_file)
      endpoint = build_url(PARSE_RESUME)
      body_params =
        {
          inputFile: raw_file,
          outputHtml: false
        }
      RestClient.post(endpoint, body(body_params).to_json, headers).body
    end

    def parse_html(raw_file)
      endpoint = build_url(PARSE_RESUME)
      body_params =
        {
          inputFile: raw_file,
          outputHtml: true
        }
      RestClient.post(endpoint, body(body_params).to_json, headers).body
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

    def body(params = {})
      {
        'DocumentAsBase64String' => file_as_base64(params[:inputFile]),
        'OutputHtml' => params[:outputHtml],
        'Configuration' => @configuration
      }
    end

    def file_as_base64(file)
      Base64.encode64(file)
    end

    def build_url(action)
      "#{@base_url}#{action}"
    end
  end
end
