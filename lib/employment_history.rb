module SovrenRest
  # Represents a single employment history record
  class EmploymentHistory
    attr_reader :title, :employer, :city, :state, :description,
                :start_date, :end_date
    def initialize(data = {})
      history = data['PositionHistory']

      parse_title(history)
      parse_employer(data)
      parse_location(history)
      parse_description(history)
      parse_dates(history)
    end

    private

    def parse_title(history = {})
      @title = history.find { |h| h['Title'] }['Title']
    end

    def parse_employer(data = {})
      @employer = data['EmployerOrgName']
    end

    # rubocop:disable Metrics/LineLength
    def parse_location(history = {})
      location = history.find { |h| h['OrgInfo'] }['OrgInfo']
                        .find { |info| info['PositionLocation'] }['PositionLocation']

      @city = location['Municipality']
      @state = location['Region'][0]
    end
    # rubocop:enable Metrics/LineLength

    def parse_description(history = {})
      @description = history.find { |h| h['Description'] }['Description']
    end

    def parse_dates(history = {})
      @start_date = history.find { |h| h['StartDate'] }['StartDate']
                           .map { |_k, v| v }[0]
      @end_date = history.find { |h| h['EndDate'] }['EndDate']
                         .map { |_k, v,| v }[0]
    end
  end
end
