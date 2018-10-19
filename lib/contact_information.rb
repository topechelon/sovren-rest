require_relative 'address'

require 'forwardable'
module SovrenRest
  # Represents resume contact information.
  class ContactInformation
    extend Forwardable
    attr_reader :first_name, :middle_name, :last_name, :email_addresses,
                :websites, :phone_numbers, :address

    def_delegators :@address, :address_line_1, :address_line_2, :city,
                   :state, :country, :postal_code

    def initialize(data)
      parse_name(data['PersonName'] || {})
      contact_method = data['ContactMethod'] || []
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
        address_line_1 == other.address_line_1 &&
        address_line_2 == other.address_line_2 &&
        city == other.city &&
        state == other.state &&
        country == other.country &&
        postal_code == other.postal_code
    end
    # rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

    private

    def parse_name(person_name)
      @first_name = person_name['GivenName']
      @last_name = person_name['FamilyName']
      @middle_name = person_name['MiddleName']
    end

    def parse_email(contact_method)
      @email_addresses = contact_method
                         .select { |cm| cm['InternetEmailAddress'] }
    end

    def parse_websites(contact_method)
      @websites = contact_method.select { |cm| cm['InternetWebAddress'] }
    end

    def parse_phone_numbers(contact_method)
      @phone_numbers = contact_method.select { |cm| cm['Telephone'] }
    end
  end
end
