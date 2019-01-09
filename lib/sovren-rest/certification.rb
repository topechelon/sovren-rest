module SovrenRest
  ##
  # Represents a certification or license.
  class Certification
    # Name of the certification/license.
    attr_reader :name

    # Description of the certification/license.
    attr_reader :description

    # Array of effective issue dates of certification/license.
    attr_reader :effective_dates

    ##
    # Initializes a new license or certification with a name,
    # description, and issue date.
    def initialize(data)
      certification = data['LicenseOrCertification'] || {}
      parse_name(certification)
      parse_description(certification)
      parse_effective_dates(certification)
    end

    def eql?(other)
      name == other.name &&
        description == other.description &&
        effective_dates == other.effective_dates
    end

    private

    def parse_name(data)
      @name = data['Name']
    end

    def parse_description(data)
      @description = data['Description']
    end

    def parse_effective_dates(data)
      date = data.dig('EffectiveDate', 'FirstIssuedDate') || {}
      @effective_dates = date.values.compact
    end
  end
end
