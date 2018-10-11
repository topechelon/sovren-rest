module SovrenRest
  # Represents a contact information postal address.
  class Address
    attr_reader :line1, :line2, :city, :state,
                :country, :postal_code

    def initialize(data = {})
      if data.nil? || data.select { |d| d['PostalAddress'] }.none?
        @city = @state = @country = @postal_code = @line1 = @line2 = 'Unknown'
      else
        address = data.find { |cm| cm['PostalAddress'] }['PostalAddress']
        parse_lines(address)
        parse_city(address)
        parse_state(address)
        parse_country(address)
        parse_postal_code(address)
      end
    end

    private

    def parse_lines(postal_address = {})
      line = postal_address['DeliveryAddress']['AddressLine']
      @line1 = line[0]
      @line2 = line[1]
    end

    def parse_city(postal_address = {})
      @city = postal_address['Municipality']
    end

    def parse_state(postal_address = {})
      @state = postal_address['Region'][0]
    end

    def parse_country(postal_address = {})
      @country = postal_address['CountryCode']
    end

    def parse_postal_code(postal_address = {})
      @postal_code = postal_address['PostalCode']
    end
  end
end
