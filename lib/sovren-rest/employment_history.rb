require_relative 'employer'

module SovrenRest
  ##
  # Represents employment history as a list of employers.
  class EmploymentHistory
    # An array of SovrenRest::Employer.
    attr_reader :employers

    ##
    # Initializes an array of past and current employers.
    def initialize(data)
      employers = data['EmployerOrg'] || []
      @employers = employers.map { |e| SovrenRest::Employer.new(e) }
    end

    ##
    # Custom equality definition.
    def eql?(other)
      employers == other.employers
    end
  end
end
