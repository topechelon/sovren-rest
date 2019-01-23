module SovrenRest
  module Category
    ##
    # A generic placeholder for a resume category
    class Generic
      attr_reader :data

      def initialize(data)
        @data = data
      end

      protected

      def compare_values(other, property)
        a = send(property)
        b = other.send(property)
        return a == b unless a.is_a?(Array)

        (a - b).empty?
      end
    end
  end
end
