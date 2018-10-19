require_relative 'position_location'
require_relative 'position_category'

require 'forwardable'

module SovrenRest
  # Represents a position at an organization.
  # Defined as...
  # {
  #   :current      => bool; Current position
  #   :title        => string; Position Title
  #   :department   => string; Department/Subdivison
  #   :description  => string; Position Description
  #   :start_date   => string/date; Start of Employment
  #   :end_date     => string/date; End of employment (if applicable)
  #   :category     => SovrenRest::PositionCategory
  #   :metadata     => hash; Additional sovren specific metadata
  #   :city         => string; Accessor for SovrenRest::PositionLocation.city
  #   :state        => string; Accessor for SovrenRest::PositionLocation.state
  #   :country      => string; Accessor for SovrenRest::PositionLocation.country
  # }
  class Position
    extend Forwardable

    attr_reader :current, :title, :department, :description, :location,
                :start_date, :end_date, :category, :metadata

    def_delegators :@location, :city, :state, :country

    def initialize(data)
      parse_current(data)
      parse_title(data)
      parse_department(data)
      parse_location(data)
      parse_description(data)
      parse_dates(data)
      parse_category(data)
      parse_metadata(data)
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
      @location = SovrenRest::PositionLocation.new(data['OrgInfo'] || [])
    end

    def parse_description(data)
      @description = data['Description']
    end

    def parse_dates(data)
      @start_date = data['StartDate'].map { |_k, v| v }[0]
      @end_date = data['EndDate'].map { |_k, v| v }[0] || 'current'
    end

    def parse_category(data)
      @category = SovrenRest::PositionCategory.new(data['JobCategory'] || [])
    end

    def parse_metadata(data)
      @metadata = data['UserArea']
    end
  end
end
