# frozen_string_literal: true

module SovrenRest
  ##
  # Interprets the response body for a /parser/resume response
  class ParseResponse
    attr_reader :response

    def initialize(raw_response)
      @response = JSON.parse(raw_response)
    end

    ##
    # HTML representation of the resume.
    def html
      value['Html']
    end

    ##
    # SovrenRest::Resume containing all parse data
    def parsed_resume
      build_resume('ParsedDocument')
    end

    ##
    # SovrenRest::Resume containing parse data with PII removed
    def scrubbed_parsed_resume
      build_resume('ScrubbedParsedDocument')
    end

    ##
    # The response code returned by Sovren
    def code
      info['Code']
    end

    ##
    # The success or error message returned by Sovren
    def message
      info['Message']
    end

    private

    def value
      @response['Value'] || {}
    end

    def info
      @response['Info']
    end

    def build_resume(key)
      document_string = value[key] || '{}'
      document = JSON.parse(document_string)
      SovrenRest::Resume.new(document)
    end
  end
end
