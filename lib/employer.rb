require_relative 'position'

module SovrenRest
  ##
  # Represents an employer for an employee. Can have many positions.
  class Employer
    # Array of SovrenRest::Position.
    attr_reader :positions

    # Name of the employer.
    attr_reader :name

    # Sovren specific employer metadata.
    attr_reader :metadata

    ##
    # Initializes a new employer and parses all positions held.
    def initialize(data)
      @name = data['EmployerOrgName']
      positions = data['PositionHistory'] || []
      @positions = positions.map { |p| SovrenRest::Position.new(p) }
      @metadata = data['UserArea']
    end

    ##
    # Custom equality definition.
    def eql?(other)
      name == other.name &&
        positions == other.positions &&
        metadata == other.metadata
    end
  end
end
