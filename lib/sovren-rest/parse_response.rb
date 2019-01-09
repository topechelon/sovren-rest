module SovrenRest
  ##
  # Interprets the response body for a /parser/resume response
  class ParseResponse
    STATUS_SUCCESS = 'Success'.freeze

    def initialize(response)
      @parsed_response = JSON.parse(response)
    end

    ##
    # HTML representation of the resume.
    def html
      value.dig('Html')
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

    def successful?
      info['Code'] == STATUS_SUCCESS
    end

    ##
    # The success or error message returned by Sovren
    def message
      info['Message']
    end

    private

    def value
      @parsed_response['Value'] || {}
    end

    def info
      @parsed_response['Info']
    end

    def build_resume(key)
      document_string = value[key] || '{}'
      document = JSON.parse(document_string)
      SovrenRest::Resume.new(document)
    end
  end
end
