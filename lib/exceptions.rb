module SovrenRest
  #
  ## Custom error encapsulating erroneous Sovren responses
  class ParsingError < StandardError
    attr_reader :response, :code

    def initialize(response, code: nil)
      @response = response
      @code = code
      super(response)
    end
  end
end
