module SovrenRest
  # Top level resume class.
  class Resume
    def initialize(response, with_html = false)
      @response = response
      @with_html = with_html
    end
  end
end
