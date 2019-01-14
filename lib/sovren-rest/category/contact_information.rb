module SovrenRest
  module Category
    ##
    # Represents resume contact information.
    class ContactInformation < Generic
      # First name, given name.
      def first_name
        person_name['GivenName']
      end

      # Middle name.
      def middle_name
        person_name['MiddleName']
      end

      # Last name, family name.
      def last_name
        person_name['FamilyName']
      end

      # Array of Sovren email address contact methods.
      def email_addresses
        contact_method.select { |cm| cm['InternetEmailAddress'] }
      end

      # Array of website addresses.
      def websites
        contact_method.select { |cm| cm['InternetWebAddress'] }
      end

      # Array of Sovren phone number contact methods.
      def phone_numbers
        contact_method.select { |cm| cm['Telephone'] }
      end

      # Array of Sovren postal address contact methods.
      def addresses
        contact_method.select { |cm| cm['PostalAddress'] }
      end

      def eql?(other)
        properties = %w[first_name middle_name last_name email_addresses
                        websites phone_numbers addresses]
        properties.all? { |property| compare_values(other, property) }
      end

      private

      def person_name
        data['PersonName'] || {}
      end

      def contact_method
        data['ContactMethod'] || []
      end
    end
  end
end
