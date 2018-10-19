module SovrenRest
  # Represents a position location in the form of:
  # {
  #   :city     => string; City name
  #   :state    => string; State name
  #   :country  => string; Country abbreviation
  # }
  #
  class PositionLocation
    attr_reader :country, :city, :state

    def initialize(data)
      find_location = data.find { |d| d['PositionLocation'] } || {}
      location = find_location.dig('PositionLocation') || {}
      @country = location.dig('CountryCode')
      @state = location.dig('Region', 0)
      @city = location.dig('Municipality')
    end
  end
end
