module SovrenRest
  # Represents position category information.
  # An array of...
  # {
  #   'TaxonomyName' => Descriptor,
  #   'CategoryCode' => Value,
  #   'Comments'     => (Optional) Metadata
  # }
  #
  class PositionCategory
    attr_reader :data

    def initialize(data)
      @data = data.map { |d| d }
    end
  end
end
