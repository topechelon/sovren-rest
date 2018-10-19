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

    attr_reader :current, :title, :department, :description,
                :start_date, :end_date, :category, :metadata

    def_delegators :@location, :city, :state, :country

    def initialize(data)
      @current = data['@currentEmployer'] || false
      @title = data['Title']
      @department = data.dig('OrgName', 'OrganizationName')
      @location = SovrenRest::PositionLocation.new(data['OrgInfo'] || [])
      @description = data['Description']
      @start_date = data['StartDate'].map { |_k, v| v }[0]
      @end_date = data['EndDate'].map { |_k, v| v }[0] || 'current'
      @category = SovrenRest::PositionCategory.new(data['JobCategory'] || [])
      @metadata = data['UserArea']
    end
  end
end
