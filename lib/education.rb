module SovrenRest
  # Represents an education record.
  class Education
    attr_reader :school_name, :degree_type, :major, :graduated, :end_date

    def initialize(data = {}); end
  end
end
