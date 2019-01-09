module SovrenRest
  module Category
    ##
    # Represents a position at an organization.
    class EmploymentPosition < Generic
      # Current position flag.
      attr_reader :current

      # Position title.
      attr_reader :title

      # Department/Subdivison.
      attr_reader :department

      # Description/summary of the position.
      attr_reader :description

      # City name.
      attr_reader :city

      # State name.
      attr_reader :state

      # Country code.
      attr_reader :country

      # Start of employment.
      attr_reader :start_date

      # End of employment.
      attr_reader :end_date

      # Array of Sovren position history job categories.
      attr_reader :categories

      # Sovren specific position metadata.
      attr_reader :metadata

      ##
      # Initializes a position summary with parsed data.
      def initialize(data)
        parse_current(data)
        parse_title(data)
        parse_department(data)
        parse_location(data)
        parse_description(data)
        parse_dates(data)
        parse_categories(data)
        parse_metadata(data)
      end

      def eql?(other)
        properties = %i[current title department description city state
                        country start_date end_date categories metadata]
        properties.all? { |property| compare_values(other, property) }
      end

      private

      def parse_current(data)
        @current = data['@currentEmployer'] || false
      end

      def parse_title(data)
        @title = data['Title']
      end

      def parse_department(data)
        @department = data.dig('OrgName', 'OrganizationName')
      end

      def parse_location(data)
        org_info = data['OrgInfo'] || []
        find_location = org_info.find { |d| d['PositionLocation'] } || {}
        location = find_location.dig('PositionLocation') || {}
        @country = location.dig('CountryCode')
        @state = location.dig('Region', 0)
        @city = location.dig('Municipality')
      end

      def parse_description(data)
        @description = data['Description']
      end

      def parse_dates(data)
        start_date = data['StartDate'] || {}
        @start_date = start_date.values[0]
        end_date = data['EndDate'] || {}
        @end_date = end_date.values[0] || 'current'
      end

      def parse_categories(data)
        categories = data['JobCategory'] || []
        @categories = categories.map { |m| m }
      end

      def parse_metadata(data)
        @metadata = data['UserArea']
      end
    end
  end
end
