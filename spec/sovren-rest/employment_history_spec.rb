require 'employment_history.rb'

RSpec.describe SovrenRest::EmploymentHistory do
  before :all do
    @employer = "Stuff N' Things"
    @state = 'Ohio'
    @city = 'Canton'
    @description = 'Doing stuff, making things'
    @start_date = '2018-05'
    @end_date = 'current'
    @title = 'Stuff-Thinger'
    input = {
      EmployerOrgName: @employer,
      PositionHistory: [
        {
          :@currentEmployer => 'true',
          :OrgName => {
            OrganizationName: @employer
          },
          :OrgInfo => [
            {
              PositionLocation: {
                CountryCode: 'US',
                Region: [@state],
                Municipality: @city
              }
            }
          ],
          :Description => @description,
          :StartDate => {
            YearMonth: @start_date
          },
          :EndDate => {
            StringDate: @end_date
          },
          :JobCategory => [
            {
              TaxonomyName: 'Skills taxonomy',
              CategoryCode: 'Information Technology → Programming',
              Comments: 'Information Technology describes 91% of this job'
            },
            {
              TaxonomyName: 'Job Level',
              CategoryCode: 'Senior (more than 5 years experience)'
            }
          ],
          :UserArea => {
            "sov:PositionHistoryUserArea": {
              "sov:Id": 'POS-1',
              "sov:CompanyNameProbabilityInterpretation": {
                :@internalUseOnly => 'BM',
                :"#text" => 'Confident'
              },
              "sov:NormalizedOrganizationName": @employer
            }
          }
        },
        {
          :@positionType => 'directHire',
          :Title => @title,
          :OrgName => {
            OrganizationName: 'Stuff and Things SaaS'
          },
          :Description => 'C#, .NET MVC, MSSql, Postgres',
          :StartDate => {
            YearMonth: '2016-06'
          },
          :EndDate => {
            YearMonth: '2018-04'
          },
          :JobCategory => [
            {
              TaxonomyName: 'Skills taxonomy',
              CategoryCode: 'Stuff → Things',
              Comments: 'Stuff describes 100% of this job'
            },
            {
              TaxonomyName: 'Job Level',
              CategoryCode: 'Senior (more than 5 years experience)'
            }
          ],
          :UserArea => {
            "sov:PositionHistoryUserArea": {
              "sov:Id": 'POS-2',
              "sov:CompanyNameProbabilityInterpretation": {
                :@internalUseOnly => 'BM',
                :"#text" => 'Confident'
              },
              "sov:PositionTitleProbabilityInterpretation": {
                :@internalUseOnly => 'TT', :"#text" => 'Confident'\
              },
              "sov:NormalizedOrganizationName": @employer,
              "sov:NormalizedTitle": @title
            }
          }
        }
      ],
      UserArea: {
        "sov:EmployerOrgUserArea": {
          "sov:NormalizedEmployerOrgName": @employer
        }
      }
    }

    @employment_history = SovrenRest::EmploymentHistory.new(input)
  end

  it 'should extract title' do
    expect(@employment_history.title).to eq(@title)
  end

  it 'should extract employer' do
    expect(@employment_history.employer).to eq(@employer)
  end

  it 'should extract state' do
    expect(@employment_history.state).to eq(@state)
  end

  it 'should extract city' do
    expect(@employment_history.city).to eq(@city)
  end

  it 'should extract description' do
    expect(@employment_history.description).to eq(@description)
  end

  it 'should extract start_date' do
    expect(@employment_history.start_date).to eq(@start_date)
  end

  it 'should extract end_date' do
    expect(@employment_history.end_date).to eq(@end_date)
  end
end
