# frozen_string_literal: true

module SovrenRest
  module Category
    ##
    # Represents a position at an organization.
    class EmploymentPosition < Generic
      # Current position flag.
      def current
        data['@currentEmployer'] || false
      end

      # Position title.
      def title
        data['Title']
      end

      # Department/Subdivison.
      def department
        data.dig('OrgName', 'OrganizationName')
      end

      # Country code.
      def country
        location['CountryCode']
      end

      # State name.
      def state
        location.dig('Region', 0)
      end

      # City name.
      def city
        location['Municipality']
      end

      # Description/summary of the position.
      def description
        data['Description']
      end

      # Start of employment.
      def start_date
        start_date = data['StartDate'] || {}
        @start_date = start_date.values[0]
      end

      # End of employment.
      def end_date
        end_date = data['EndDate'] || {}
        @end_date = end_date.values[0] || 'current'
      end

      # Array of Sovren position history job categories.
      def categories
        data['JobCategory'] || []
      end

      # Sovren specific position metadata.
      def metadata
        data['UserArea']
      end

      def eql?(other)
        properties = %i[current title department description city state
                        country start_date end_date categories metadata]
        properties.all? { |property| compare_values(other, property) }
      end

      private

      def location
        org_info = data['OrgInfo'] || []
        find_location = org_info.find { |d| d['PositionLocation'] } || {}
        find_location['PositionLocation'] || {}
      end
    end
  end
end
