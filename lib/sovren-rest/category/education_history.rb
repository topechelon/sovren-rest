module SovrenRest
  module Category
    ##
    # Represents a resume education history.
    class EducationHistory < Generic
      # HROpenStandards school type.
      def school_type
        data.dig('@schoolType')
      end

      # Name of the school or institutution.
      def school_name
        data.dig('School', 0, 'SchoolName')
      end

      # HROpenStandards degree type.
      def degree_type
        data.dig('Degree', 0, '@degreeType')
      end

      # Name of the degree.
      def degree_name
        data.dig('Degree', 0, 'DegreeName')
      end

      # Major distinction for the degree.
      def degree_major
        data.dig('Degree', 0, 'DegreeMajor', 0, 'Name', 0)
      end

      # Date started work on degree.
      def start_date
        date = dates_of_attendance['StartDate'] || {}
        date.values[0]
      end

      # Date ended work on degree.
      def end_date
        date = dates_of_attendance['EndDate'] || {}
        date.values[0]
      end

      # Sovren graduated flag.
      def graduated
        data.dig('Degree', 0, 'UserArea', 'sov:DegreeUserArea', 'sov:Graduated')
      end

      # Additional comments.
      def comments
        data.dig('Degree', 0, 'Comments')
      end

      # School/institution city name.
      def city
        location['Municipality']
      end

      # School/institution state name.
      def state
        location.dig('Region', 0)
      end

      # School/institution country code.
      def country
        location['CountryCode']
      end

      # Sovren specific education data.
      def metadata
        data.dig('Degree', 0, 'UserArea')
      end

      def eql?(other)
        properties = %i[school_name school_type degree_type
                        degree_major start_date end_date comments
                        city state metadata graduated]
        properties.all? { |property| compare_values(other, property) }
      end

      private

      def dates_of_attendance
        data.dig('Degree', 0, 'DatesOfAttendance', 0) || {}
      end

      def location
        data['PostalAddress'] || {}
      end
    end
  end
end
