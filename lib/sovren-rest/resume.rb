module SovrenRest
  ##
  # Top level resume class, an aggregation of resume information held.
  class Resume
    # SovrenRest::ContactInformation.
    attr_reader :contact_information

    # SovrenRest::EmploymentHistory.
    attr_reader :employment_history

    # SovrenRest::EducationHistory.
    attr_reader :education_history

    # Array of SovrenRest::Certification.
    attr_reader :certifications

    # Sovren specific resume metadata.
    attr_reader :metadata

    ##
    # Initializes a resume from ParsedDocument data.
    def initialize(document)
      data = document.dig('Resume', 'StructuredXMLResume')
      user_area = document.dig('Resume', 'UserArea')
      build_resume(data || {}, user_area || {})
    end

    # rubocop:disable Metrics/AbcSize

    ##
    # Custom equality definition.
    def eql?(other)
      contact_information == other.contact_information &&
        employment_history == other.employment_history &&
        education_history == other.education_history &&
        certifications == other.certifications &&
        metadata == other.metadata
    end
    # rubocop:enable Metrics/AbcSize

    private

    def build_resume(data, user_area)
      @contact_information = build_contact_information(data)
      @employment_history = build_employment_history(data)
      @education_history = build_education_history(data)
      @certifications = build_certifications(data)
      @metadata = build_metadata(user_area)
    end

    def build_contact_information(data)
      SovrenRest::ContactInformation.new(data['ContactInfo'] || {})
    end

    def build_employment_history(data)
      arr = data.dig('EmploymentHistory', 'EmployerOrg') || []
      arr.map { |emp| SovrenRest::EmploymentHistory.new(emp) }
    end

    def build_education_history(data)
      arr = data.dig('EducationHistory', 'SchoolOrInstitution') || []
      arr.map { |edu| SovrenRest::EducationHistory.new(edu) }
    end

    def build_certifications(data)
      arr = data['LicensesAndCertifications'] || []
      arr.map { |lac| SovrenRest::Certification.new(lac) }
    end

    def build_metadata(user_area)
      user_area.dig('sov:ResumeUserArea') || {}
    end
  end
end
