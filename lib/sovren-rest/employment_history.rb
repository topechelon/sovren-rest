require_relative 'employment_position'

module SovrenRest
  ##
  # Represents an employer for an employee. Can have many positions.
  class EmploymentHistory
    # Employment History json
    attr_reader :data

    ##
    # Initializes a new employer and parses all positions held.
    def initialize(data)
      @data = data
    end

    # Name of the employer.
    def company_name
      data['EmployerOrgName']
    end

    # Array of SovrenRest::EmploymentPosition
    def employment_positions
      employment_positions = data['PositionHistory'] || []
      @employment_positions ||= employment_positions.map do |position|
        SovrenRest::EmploymentPosition.new(position)
      end
    end

    # Sovren-specific employer metadata.
    def metadata
      data['UserArea']
    end

    def eql?(other)
      properties = %i[company_name employment_positions metadata]
      properties.all? { |property| send(property) == other.send(property) }
    end
  end
end
