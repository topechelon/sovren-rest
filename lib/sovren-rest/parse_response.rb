module SovrenRest
  ##
  # Interprets the response body for a /parser/resume response
  class ParseResponse
    STATUS_SUCCESS = 'Success'.freeze

    def initialize(response)
      @parsed_response = JSON.parse(response)
      @parsed_value = @parsed_response['Value'] || {}
    end

    ##
    # HTML representation of the resume.
    def html
      @parsed_value.dig('Html')
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
      status['Code'] == STATUS_SUCCESS
    end

    ##
    # The success or error message returned by Sovren
    def message
      status['Message']
    end

    private

    def status
      @parsed_response['Info']
    end

    def build_resume(key)
      document_string = @parsed_value[key] || '{}'
      document = JSON.parse(document_string)
      SovrenRest::Resume.new(document)
    end
  end
end
