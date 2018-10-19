module SovrenRest
  # Top level resume class.
  class Resume
    attr_reader :contact_information, :employment_history, :education_history,
                :certifications, :experience_summary, :html

    def initialize(response)
      parsed_response = JSON.parse(response)
      parsed_value = parsed_response['Value']
      parsed_document = JSON.parse(parsed_value['ParsedDocument'])
      data = parsed_document['Resume']['StructuredXMLResume']
      user_area = parsed_document['Resume']['UserArea']
      build_resume(data, user_area)
      @html = parsed_value['Html']
    end

    # rubocop:disable Metrics/AbcSize
    def eql?(other)
      contact_information == other.contact_information &&
        employment_history == other.employment_history &&
        education_history == other.education_history &&
        certifications == other.certifications &&
        experience_summary == other.experience_summary
    end
    # rubocop:enable Metrics/AbcSize

    private

    def build_resume(data, user_area)
      @contact_information = build_contact_information(data)
      @employment_history = build_employment_history(data)
      @education_history = build_education_history(data)
      @certifications = build_certifications(data)
      @experience_summary = build_experience_summary(user_area)
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

    def build_experience_summary(user_area)
      exp = user_area.dig('sov:ResumeUserArea', 'sov:ExperienceSummary') || {}
      SovrenRest::ExperienceSummary.new(exp)
    end
  end
end
