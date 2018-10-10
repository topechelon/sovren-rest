module SovrenRest
  # Represents a persons experience summary.
  class ExperienceSummary
    attr_reader :years_of_work_experience, :months_of_work_experience

    def initialize(data = {})
      @months_of_work_experience = data['sov:MonthsOfWorkExperience'].to_i
      @years_of_work_experience = (@months_of_work_experience / 12).floor
    end

    def eql?(other)
      years_of_work_experience == other.years_of_work_experience &&
        months_of_work_experience == other.months_of_work_experience
    end
  end
end
