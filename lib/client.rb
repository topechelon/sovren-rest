require 'base64'
require 'json'

module SovrenRest
  class Client
    PARSE_RESUME='/parser/resume'
    def initialize(options={})
      @baseUrl = options[:baseUrl]
      @accountId = options[:accountId] || '12345678'
      @serviceKey = options[:serviceKey] || 'thiscanbeanything,whyrequireit?'
    end

    def parse(rawFile)
      endpoint = build_url(PARSE_RESUME)
      body_params =
        {
          inputFile: rawFile,
          outputHtml: false
        }
      response = RestClient.post(endpoint, body(body_params).to_json, headers)
    end

    private

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Sovren-AccountId' => @accountId,
        'Sovren-ServiceKey' => @serviceKey
      }
    end

    def body(params={})
      {
        "DocumentAsBase64String" => file_as_base64(params[:inputFile]),
        "OutputHtml" => params[:outputHtml]
      }
    end

    def file_as_base64(file)
      Base64.encode64(file)
    end

    def build_url(action)
      "#{@baseUrl}#{action}"
    end
  end
end