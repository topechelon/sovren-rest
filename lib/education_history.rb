module SovrenRest
  # Represents an education record.
  class EducationHistory
    attr_reader :school_name, :degree_type, :major, :graduated, :end_date

    def initialize(data)
      parse_school_name(data)
      parse_degree_type(data)
      parse_major(data)
      parse_end_date(data)
      parse_graduated(data)
    end

    # rubocop:disable Metrics/AbcSize
    def eql?(other)
      school_name == other.school_name &&
        degree_type == other.degree_type &&
        major == other.major &&
        graduated == other.graduated &&
        end_date == other.end_date
    end
    # rubocop:enable Metrics/AbcSize

    private

    def parse_school_name(school)
      @school_name = school.dig('School', 0, 'SchoolName')
    end

    def parse_degree_type(school)
      @degree_type = school.dig('Degree', 0, '@degreeType')
    end

    def parse_major(school)
      @major = school.dig('Degree', 0, 'DegreeMajor', 0, 'Name', 0)
    end

    def parse_end_date(school)
      end_date = school.dig('Degree', 0, 'DatesOfAttendance',
                            0, 'EndDate') || {}
      @end_date = end_date.values[0]
    end

    def parse_graduated(school)
      @graduated = school.dig('Degree', 0, 'UserArea',
                              'sov:DegreeUserArea', 'sov:Graduated')
    end
  end
end
