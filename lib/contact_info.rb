module SovrenRest
  class ContactInfo
    attr_reader :first_name, :middle_name, :last_name, :email_addresses, :websites, :phone_numbers,
                :address_line_1, :address_line_2, :city, :state, :country, :postal_code

    def initialize(data = {})
      personName = data['PersonName']
      @first_name = personName['GivenName']
      @last_name = personName['FamilyName']
      @middle_name = personName['MiddleName'] || ''

      @email_addresses = data['ContactMethod']
                         .select { |cm| cm['InternetEmailAddress'] }
                         .map { |cm| cm['InternetEmailAddress'] }

      @websites = data['ContactMethod']
                  .select { |cm| cm['InternetWebAddress'] }
                  .map { |cm| cm['InternetWebAddress'] }

      @phone_numbers = data['ContactMethod']
                       .select { |cm| cm['Telephone'] }
                       .map { |phone| phone['Telephone']['FormattedNumber'] }

      postalAddress = data['ContactMethod']
                      .find { |cm| !cm['PostalAddress'].nil? }['PostalAddress']

      addressLine = postalAddress['DeliveryAddress']['AddressLine']

      @address_line_1 = addressLine[0]

      @address_line_2 = addressLine[1]

      @city = postalAddress['Municipality']

      @state = postalAddress['Region'][0]

      @country = postalAddress['CountryCode']

      @postal_code = postalAddress['PostalCode']
    end
  end
end
