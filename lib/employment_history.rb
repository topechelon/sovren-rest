module SovrenRest
  class EmploymentHistory
    attr_reader :title, :employer, :city, :state, :description, :start_date, :end_date
    def initialize(data = {})
      history = data[:PositionHistory]
      @title = history.find { |h| h[:Title] }[:Title]
      @employer = data[:EmployerOrgName]
      location = history.find { |h| h[:OrgInfo] }[:OrgInfo].find { |info| info[:PositionLocation] }[:PositionLocation]
      @city = location[:Municipality]
      @state = location[:Region][0]
      @description = history.find { |h| h[:Description] }[:Description]
      @start_date = history.find { |h| h[:StartDate] }[:StartDate].map { |_k, v| v }[0]
      @end_date = history.find { |h| h[:EndDate] }[:EndDate].map { |_k, v,| v }[0]
    end
  end
end
