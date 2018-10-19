require_relative 'position'

module SovrenRest
  # Represents an employer for an employee. Can have many positions.
  class Employer
    attr_reader :positions, :name, :metadata

    def initialize(data)
      @name = data['EmployerOrgName']
      positions = data['PositionHistory'] || []
      @positions = positions.map { |p| SovrenRest::Position.new(p) }
      @metadata = data['UserArea']
    end
  end
end
