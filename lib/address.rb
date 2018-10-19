module SovrenRest
  # Represents a contact information postal address.
  class Address
    attr_reader :address_line_1, :address_line_2, :city, :state,
                :country, :postal_code

    def initialize(data)
      if data.select { |d| d['PostalAddress'] }.none?
        @city = @state = @country = @postal_code = @address_line_1 =
                                                     @address_line_2 = nil
      else
        address = data.find { |cm| cm['PostalAddress'] }['PostalAddress']
        parse_lines(address)
        parse_city_state(address)
        parse_country(address)
        parse_postal_code(address)
      end
    end

    private

    def parse_lines(postal_address)
      line = postal_address.dig('DeliveryAddress', 'AddressLine') || []
      @address_line_1 = line.dig(0)
      @address_line_2 = line.dig(1)
    end

    def parse_city_state(postal_address)
      @city = postal_address.dig('Municipality')
      @state = postal_address.dig('Region', 0)
    end

    def parse_country(postal_address)
      @country = postal_address.dig('CountryCode')
    end

    def parse_postal_code(postal_address)
      @postal_code = postal_address.dig('PostalCode')
    end
  end
end
