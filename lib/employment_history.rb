require_relative 'employer'

module SovrenRest
  # Represents a single employment history record
  class EmploymentHistory

    attr_reader :employers

    def initialize(data)
      employers = data['EmployerOrg'] || []
      @employers = employers.map { |e| SovrenRest::Employer.new(e) }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def eql?(other)
      employers == other.employers
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
  end
end
