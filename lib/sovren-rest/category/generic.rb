module SovrenRest
  module Category
    class Generic
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
