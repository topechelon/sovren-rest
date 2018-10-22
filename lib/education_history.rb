module SovrenRest
  ##
  # Represents a resume education history.
  class EducationHistory
    # HROpenStandards school type.
    attr_reader :school_type

    # Name of the school or institutution.
    attr_reader :school_name

    # HROpenStandards degree type.
    attr_reader :degree_type

    # Name of the degree.
    attr_reader :degree_name

    # Major distinction for the degree.
    attr_reader :degree_major

    # Sovren graduated flag.
    attr_reader :graduated

    # Date started work on degree.
    attr_reader :start_date

    # Date ended work on degree.
    attr_reader :end_date

    # Additional comments.
    attr_reader :comments

    # School/institution city name.
    attr_reader :city

    # School/institution state name.
    attr_reader :state

    # School/institution country code.
    attr_reader :country

    # Sovren specific education data.
    attr_reader :metadata

    ##
    # Initializes Education History with parsed school or institution data.
    def initialize(data)
      parse_school(data)
      parse_degree(data)
      parse_dates(data)
      parse_metadata(data)
      parse_location(data)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity

    ##
    # Custom equality definition.
    def eql?(other)
      school_name == other.school_name &&
        school_type == other.school_type &&
        degree_type == other.degree_type &&
        degree_major == other.degree_major &&
        degree_type == other.degree_type &&
        start_date == other.start_date &&
        end_date == other.end_date &&
        comments == other.comments &&
        city == other.city &&
        state == other.state &&
        metadata == other.metadata &&
        graduated == other.graduated
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity

    private

    def parse_school(school)
      @school_type = school.dig('@schoolType')
      @school_name = school.dig('School', 0, 'SchoolName')
    end

    def parse_degree(school)
      @degree_type = school.dig('Degree', 0, '@degreeType')
      @degree_major = school.dig('Degree', 0, 'DegreeName')
      @degree_major = school.dig('Degree', 0, 'DegreeMajor', 0, 'Name', 0)
    end

    def parse_dates(school)
      dates = school.dig('Degree', 0, 'DatesOfAttendance', 0) || {}
      start_date = dates['StartDate'] || {}
      @start_date = start_date.values[0]
      end_date = dates['EndDate'] || {}
      @end_date = end_date.values[0]
    end

    def parse_metadata(school)
      @graduated = school.dig('Degree', 0, 'UserArea',
                              'sov:DegreeUserArea', 'sov:Graduated')
      @comments = school.dig('Degree', 0, 'Comments')
      @metadata = school.dig('Degree', 0, 'UserArea')
    end

    def parse_location(data)
      location = data['PostalAddress'] || {}
      @city = location['Municipality']
      @state = location.dig('Region', 0)
      @country = location['CountryCode']
    end
  end
end
