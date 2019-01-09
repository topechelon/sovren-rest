module SovrenRest
  module Category
    ##
    # Represents resume contact information.
    class ContactInformation < Generic
      # First name, given name.
      attr_reader :first_name

      # Middle name.
      attr_reader :middle_name

      # Last name, family name.
      attr_reader :last_name

      # Array of Sovren email address contact methods.
      attr_reader :email_addresses

      # Array of website addresses.
      attr_reader :websites

      # Array of Sovren phone number contact methods.
      attr_reader :phone_numbers

      # Array of Sovren postal address contact methods.
      attr_reader :addresses

      ##
      # Initializes Contact Information with parsed data.
      def initialize(data)
        parse_name(data['PersonName'] || {})
        contact_method = data['ContactMethod'] || []
        parse_email(contact_method)
        parse_websites(contact_method)
        parse_phone_numbers(contact_method)
        parse_addresses(contact_method)
      end

      def eql?(other)
        properties = %w[first_name middle_name last_name email_addresses
                        websites phone_numbers addresses]
        properties.all? { |property| compare_values(other, property) }
      end

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

      def parse_addresses(contact_method)
        @addresses = contact_method.select { |cm| cm['PostalAddress'] }
      end
    end
  end
end
