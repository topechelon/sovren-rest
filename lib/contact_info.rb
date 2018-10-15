module SovrenRest
  # Represents resume contact information.
  class ContactInfo
    attr_reader :first_name, :middle_name, :last_name, :email_addresses,
                :websites, :phone_numbers, :address

    def initialize(data = {})
      parse_name(data['PersonName'])
      contact_method = data['ContactMethod']
      parse_email(contact_method)
      parse_websites(contact_method)
      parse_phone_numbers(contact_method)
      @address = SovrenRest::Address.new(contact_method)
    end

    # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def eql?(other)
      first_name == other.first_name &&
        middle_name == other.middle_name &&
        last_name == other.last_name &&
        email_addresses == other.email_addresses &&
        websites == other.websites &&
        phone_numbers == other.phone_numbers &&
        address_line1 == other.address_line1 &&
        address_line2 == other.address_line2 &&
        city == other.city &&
        state == other.state &&
        country == other.country &&
        postal_code == other.postal_code
    end
    # rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

    def address_line1
      @address.line1
    end

    def address_line2
      @address.line2
    end

    def city
      @address.city
    end

    def state
      @address.state
    end

    def country
      @address.country
    end

    def postal_code
      @address.postal_code
    end

    private

    def parse_name(person_name = {})
      if person_name.nil?
        @first_name = 'Unknown'
        @last_name = 'Unknown'
        @middle_name = 'Unknown'
      else
        @first_name = person_name['GivenName']
        @last_name = person_name['FamilyName']
        @middle_name = person_name['MiddleName'] || ''
      end
    end

    def parse_email(contact_method = {})
      if contact_method.nil?
        @email_addresses = []
      else
        @email_addresses = contact_method
                           .map { |cm| cm['InternetEmailAddress'] }.compact
      end
    end

    def parse_websites(contact_method = {})
      @websites = if contact_method.nil?
                    []
                  else
                    contact_method
                      .select { |cm| cm['InternetWebAddress'] }
                      .map { |cm| cm['InternetWebAddress'] }
                  end
    end

    def parse_phone_numbers(contact_method = {})
      if contact_method.nil?
        @phone_numbers = []
      else
        @phone_numbers = contact_method
                         .select { |cm| cm['Telephone'] }
                         .map { |phone| phone['Telephone']['FormattedNumber'] }
      end
    end
  end
end
