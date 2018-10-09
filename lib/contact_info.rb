module SovrenRest
  # Represents resume contact information.
  class ContactInfo
    attr_reader :first_name, :middle_name, :last_name, :email_addresses,
                :websites, :phone_numbers, :address_line1, :address_line2,
                :city, :state, :country, :postal_code

    def initialize(data = {})
      parse_name(data['PersonName'])
      contact_method = data['ContactMethod']
      parse_email(contact_method)
      parse_websites(contact_method)
      parse_phone_numbers(contact_method)
      parse_address(contact_method)
    end

    private

    def parse_name(person_name = {})
      @first_name = person_name['GivenName']
      @last_name = person_name['FamilyName']
      @middle_name = person_name['MiddleName'] || ''
    end

    def parse_email(contact_method = {})
      @email_addresses = contact_method
                         .map { |cm| cm['InternetEmailAddress'] }.compact
    end

    def parse_websites(contact_method = {})
      @websites = contact_method
                  .select { |cm| cm['InternetWebAddress'] }
                  .map { |cm| cm['InternetWebAddress'] }
    end

    def parse_phone_numbers(contact_method = {})
      @phone_numbers = contact_method
                       .select { |cm| cm['Telephone'] }
                       .map { |phone| phone['Telephone']['FormattedNumber'] }
    end

    def parse_address(contact_method = {})
      postal_address = contact_method
                       .find { |cm| cm['PostalAddress'] }['PostalAddress']
      address_line = postal_address['DeliveryAddress']['AddressLine']

      @address_line1 = address_line[0]
      @address_line2 = address_line[1]
      @city = postal_address['Municipality']
      @state = postal_address['Region'][0]
      @country = postal_address['CountryCode']
      @postal_code = postal_address['PostalCode']
    end
  end
end
