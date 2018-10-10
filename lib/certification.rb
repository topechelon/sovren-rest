module SovrenRest
  # Represents a certification.
  class Certification
    attr_reader :name, :description, :effective_date
    def initialize(data = {})
      certification = data['LicenseOrCertification']
      parse_name(certification)
      parse_description(certification)
      parse_effective_date(certification)
    end

    def eql?(other)
      name == other.name &&
        description == other.description &&
        effective_date == other.effective_date
    end

    private

    def parse_name(data = {})
      @name = data['Name']
    end

    def parse_description(data = {})
      @description = data['Description']
    end

    def parse_effective_date(data = {})
      @effective_date = data['EffectiveDate']['FirstIssuedDate']
                        .map { |_k, v| v }[0]
    end
  end
end
