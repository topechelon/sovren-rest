# frozen_string_literal: true

require_relative 'employment_position'

module SovrenRest
  module Category
    ##
    # Represents an employer for an employee. Can have many positions.
    class EmploymentHistory < Generic
      # Name of the employer.
      def company_name
        data['EmployerOrgName']
      end

      # City of the employer.
      def city
        data['City']
      end

      # State of the employer.
      def state
        data['State']
      end

      # Array of SovrenRest::EmploymentPosition
      def employment_positions
        employment_positions = data['PositionHistory'] || []
        @employment_positions ||= employment_positions.map do |position|
          SovrenRest::Category::EmploymentPosition.new(position)
        end
      end

      # Sovren-specific employer metadata.
      def metadata
        data['UserArea']
      end

      def eql?(other)
        properties = %i[company_name metadata]
        properties.all? { |property| compare_values(other, property) }
      end
    end
  end
end
