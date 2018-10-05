require 'education.rb'

RSpec.describe SovrenRest::Education do
  before :all do
    @school_name = 'University of Stuff'
    @degree_type = 'masters'
    @major = 'Stuff N Things'
    @end_date = '2016-08'
    @graduated = 'false'

    input =
      {
        "SchoolOrInstitution": [
          {
            "@schoolType": 'university',
            "School": [
              {
                "SchoolName": @school_name
              }
            ],
            "PostalAddress": {
              "CountryCode": 'US',
              "Region": [
                'Ohio'
              ],
              "Municipality": 'Akron'
            },
            "Degree": [
              {
                "@degreeType": @degree_type,
                "DegreeName": 'Master of Stuff in Things',
                "DegreeMajor": [
                  {
                    "Name": [
                      @major
                    ]
                  }
                ],
                "DatesOfAttendance": [
                  {
                    "StartDate": {
                      "AnyDate": 'notKnown'
                    },
                    "EndDate": {
                      "YearMonth": @end_date
                    }
                  }
                ],
                "Comments": "University of Akron - Akron, Ohio\r\n\r\nMaster of Science in Computer Science, Aug 2016\r\nThesis: Towards an Ideal Execution Environment for Programmable Network Switches",
                "UserArea": {
                  "sov:DegreeUserArea": {
                    "sov:Id": 'DEG-1',
                    "sov:Graduated": @graduated,
                    "sov:NormalizedDegreeName": 'MSc',
                    "sov:NormalizedDegreeType": 'MSc'
                  }
                }
              }
            ],
            "UserArea": {
              "sov:SchoolOrInstitutionTypeUserArea": {
                "sov:NormalizedSchoolName": @school_name
              }
            }
          }
        ]
      }

    @education = SovrenRest::Education.new(input)
  end

  it 'should extract school_name' do
    expect(@education.school_name).to eq(@school_name)
  end

  it 'should extract degree_type' do
    expect(@education.degree_type).to eq(@degree_type)
  end

  it 'should extract major' do
    expect(@education.major).to eq(@major)
  end

  it 'should extract graduated' do
    expect(@education.graduated).to eq(@graduated)
  end

  it 'should extract end_date' do
    expect(@education.end_date).to eq(@end_date)
  end
end
