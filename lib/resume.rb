module SovrenRest
  # Top level resume class.
  class Resume
    attr_reader :contact_info, :employment_history, :education_history,
                :certifications, :experience_summary

    def initialize(response, with_html = false)
      parsed_response = JSON.parse(response)
      parsed_value = parsed_response['Value']
      @data = parsed_value['Resume']['StructuredXMLResume']
      @user_area = parsed_value['Resume']['UserArea']
      @with_html = with_html
      build_resume
    end

    def eql?(other)
      contact_info == other.contact_info &&
        employment_history == other.employment_history &&
        education_history == other.education_history &&
        certifications == other.certifications &&
        experience_summary == other.experience_summary
    end

    private

    def build_resume
      @contact_info = build_contact_info
      @employment_history = build_employment_history
      @education_history = build_education_history
      @certifications = build_certifications
      @experience_summary = build_experience_summary
    end

    def build_contact_info
      SovrenRest::ContactInfo.new(@data['ContactInfo'])
    end

    def build_employment_history
      @data['EmploymentHistory']['EmployerOrg']
        .map { |emp| SovrenRest::EmploymentHistory.new(emp) }
        .compact
    end

    def build_education_history
      @data['EducationHistory']['SchoolOrInstitution']
        .map { |edu| SovrenRest::EducationHistory.new(edu) }
        .compact
    end

    def build_certifications
      @data['LicensesAndCertifications']
        .each { |lac| SovrenRest::Certification.new(lac) }
        .compact
    end

    def build_experience_summary
      resume_area = @user_area['sov:ResumeUserArea']
      summary = resume_area['sov:ExperienceSummary']
      SovrenRest::ExperienceSummary.new(summary)
    end
  end
end
