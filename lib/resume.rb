module SovrenRest
  # Top level resume class.
  class Resume
    attr_reader :contact_info, :employment_history, :education_history,
                :certifications, :experience_summary, :html

    def initialize(response)
      parsed_response = JSON.parse(response)
      parsed_value = parsed_response['Value']
      parsed_document = JSON.parse(parsed_value['ParsedDocument'])
      data = parsed_document['Resume']['StructuredXMLResume']
      user_area = parsed_document['Resume']['UserArea']
      @html = parsed_value['Html']
    end

    # rubocop:disable Metrics/AbcSize
    def eql?(other)
      contact_info == other.contact_info &&
        employment_history == other.employment_history &&
        education_history == other.education_history &&
        certifications == other.certifications &&
        experience_summary == other.experience_summary
    end
    # rubocop:enable Metrics/AbcSize

    private

    def build_resume(data, user_area)
      @contact_info = build_contact_info(data)
      @employment_history = build_employment_history(data)
      @education_history = build_education_history(data)
      @certifications = build_certifications(data)
      @experience_summary = build_experience_summary(user_area)
      @html = parse_html(data)
    end

    def build_contact_info(data)
      SovrenRest::ContactInfo.new(data['ContactInfo'])
    end

    def build_employment_history(data)
      data['EmploymentHistory']['EmployerOrg']
        .map { |emp| SovrenRest::EmploymentHistory.new(emp) }
        .compact
    end

    def build_education_history(data)
      data['EducationHistory']['SchoolOrInstitution']
        .map { |edu| SovrenRest::EducationHistory.new(edu) }
        .compact
    end

    def build_certifications(data)
      if data.key?('LicensesAndCertifications')
        data['LicensesAndCertifications']
          .each { |lac| SovrenRest::Certification.new(lac) }
          .compact
      else
        ''
      end
    end

    def build_experience_summary(user_area)
      resume_area = user_area['sov:ResumeUserArea']
      summary = resume_area['sov:ExperienceSummary']
      SovrenRest::ExperienceSummary.new(summary)
    end
  end
end
