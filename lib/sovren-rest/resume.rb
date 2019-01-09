module SovrenRest
  ##
  # Top level resume class, an aggregation of resume information held.
  class Resume
    # Document JSON provided by the response
    attr_reader :data

    ##
    # Initializes a resume from ParsedDocument data.
    def initialize(data)
      @data = data
    end

    # SovrenRest::ContactInformation
    def contact_information
      path = %w[ContactInfo]
      contact_info = xml_resume.dig(*path) || {}
      @contact_information ||= SovrenRest::ContactInformation.new(contact_info)
    end

    # Array of SovrenRest::EmploymentHistory
    def employment_history
      path = %w[EmploymentHistory EmployerOrg]
      arr = xml_resume.dig(*path) || []
      @employment_history ||= arr.map do |employment_history|
        SovrenRest::EmploymentHistory.new(employment_history)
      end
    end

    # Array of SovrenRest::EducationHistory
    def education_history
      path = %w[EducationHistory SchoolOrInstitution]
      arr = xml_resume.dig(*path) || []
      @education_history ||= arr.map do |education|
        SovrenRest::EducationHistory.new(education)
      end
    end

    # Array of SovrenRest::Certification
    def certifications
      path = %w[LicensesAndCertifications LicenseOrCertification]
      arr = xml_resume.dig(*path) || []
      @certifications ||= arr.map do |certification|
        SovrenRest::Certification.new(certification)
      end
    end

    # Sovren-specific resume metadata.
    def metadata
      user_area.dig('sov:ResumeUserArea') || {}
    end

    def eql?(other)
      properties = %i[contact_information employment_history
                      education_history certifications metadata]
      properties.all? { |property| send(property) == other.send(property) }
    end

    private

    def xml_resume
      data.dig('Resume', 'StructuredXMLResume') || {}
    end

    def user_area
      data.dig('Resume', 'UserArea') || {}
    end
  end
end
