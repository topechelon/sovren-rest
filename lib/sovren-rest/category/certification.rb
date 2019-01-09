module SovrenRest
  module Category
    ##
    # Represents a certification or license.
    class Certification < Generic
      # Certification json
      attr_reader :data

      ##
      # Initializes a new license or certification with a name,
      # description, and issue date.
      def initialize(data)
        @data = data
      end

      # Name of the certification/license.
      def name
        data['Name']
      end

      # Description of the certification/license.
      def description
        data['Description']
      end

      # Array of effective issue dates of certification/license.
      def effective_dates
        date = data.dig('EffectiveDate', 'FirstIssuedDate') || {}
        date.values.compact
      end

      def eql?(other)
        properties = %i[name description effective_dates]
        properties.each { |property| compare_values(other, property) }
      end
    end
  end
end
