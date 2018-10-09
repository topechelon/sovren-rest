module SovrenRest
  # Top level resume class.
  class Resume
    attr_reader :contact_info, :employment_history, :education_history,
                :certifications, :experience_summary

    def initialize(response, with_html = false)
      puts response
      parsed_response = JSON.parse(response['Value']['ParsedDocument'])
      @data = parsed_response[:Resume][:StructuredXMLResume]
      @with_html = with_html
      build_resume
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
      SovrenRest::ContactInfo.new(@data[:ContactInfo])
    end

    def build_employment_history
      @data[:EmploymentHistory][:EmployerOrg]
        .map { |emp| SovrenRest::EmploymentHistory.new(emp) }
        .compact
    end

    def build_education_history
      @data[:EducationHistory][:SchoolorInstitution]
        .map { |edu| SovrenRest::EducationHistory.new(edu) }
        .compact
    end

    def build_certifications
      @data[:LicensesAndCertifications]
        .map { |lac| SovrenRest::Certications.new(lac) }
        .compact
    end

    def build_experience_summary
      resume_area = @data[:UserArea][:"sov:ResumeUserArea"]
      summary = resume_area[:"sov:ExperienceSummary"]
      SovrenRest::ExperienceSummary(summary)
    end
  end
end
