module SovrenRest
  # Represents an education record.
  class EducationHistory
    attr_reader :school_name, :degree_type, :major, :graduated, :end_date

    def initialize(data = {})
      parse_school_name(data)
      parse_degree_type(data)
      parse_major(data)
      parse_end_date(data)
      parse_graduated(data)
    end

    def eql?(other)
      self.school_name == other.school_name &&
      self.degree_type == other.degree_type &&
      self.major == other.major &&
      self.graduated == other.graduated &&
      self.end_date == other.end_date
    end

    private

    def parse_school_name(school = {})
      @school_name = school['School'][0]['SchoolName']
    end

    def parse_degree_type(school = {})
      @degree_type = school['Degree'][0]['@degreeType']
    end

    def parse_major(school = {})
      @major = school['Degree'][0]['DegreeMajor'][0]['Name'][0]
    end

    def parse_end_date(school = {})
      @end_date = school['Degree'][0]['DatesOfAttendance'][0]['EndDate']
                  .map { |_k, v| v }[0]
    end

    def parse_graduated(school = {})
      user_area = school['Degree'][0]['UserArea']['sov:DegreeUserArea']
      @graduated = user_area['sov:Graudated'] ? 'true' : 'false'
    end
  end
end
