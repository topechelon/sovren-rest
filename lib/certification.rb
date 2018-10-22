module SovrenRest
  ##
  # Represents a certification or license.
  class Certification
    # Name of the certification/license.
    attr_reader :name

    # Description of the certification/license.
    attr_reader :description

    # Effective issue date of certification/license.
    attr_reader :effective_date

    ##
    # Initializes a new license or certification with a name,
    # description, and issue date.
    def initialize(data)
      certification = data['LicenseOrCertification'] || {}
      parse_name(certification)
      parse_description(certification)
      parse_effective_date(certification)
    end

    ##
    # Custom equality definition.
    def eql?(other)
      name == other.name &&
        description == other.description &&
        effective_date == other.effective_date
    end

    private

    def parse_name(data)
      @name = data['Name']
    end

    def parse_description(data)
      @description = data['Description']
    end

    def parse_effective_date(data)
      date = data.dig('EffectiveDate', 'FirstIssuedDate') || {}
      @effective_date = date.values[0]
    end
  end
end
