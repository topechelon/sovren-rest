module SovrenRest
  # Represents a persons experience summary.
  class ExperienceSummary
    attr_reader :years_of_work_experience, :months_of_work_experience

    def initialize(data = {})
      puts data
      @months_of_work_experience = data[:"sov:MonthsOfWorkExperience"].to_i
      @years_of_work_experience = (@months_of_work_experience / 12).floor
    end
  end
end
