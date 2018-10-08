require 'base64'
require 'json'
require 'rest-client'

# A wrapper for interacting with the sovren
# resume parser REST api V9.
module SovrenRest
  class << self
    def configure
      yield self
      true
    end
    require_relative 'certification'
    require_relative 'client'
    require_relative 'contact_info'
    require_relative 'education'
    require_relative 'employment_history'
    require_relative 'resume'
    require_relative 'experience_summary'
  end
end
