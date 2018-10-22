require 'base64'
require 'json'
require 'rest-client'

##
# A wrapper for interacting with the sovren
# resume parser REST api V9.
module SovrenRest
  require_relative 'certification'
  require_relative 'client'
  require_relative 'contact_information'
  require_relative 'education_history'
  require_relative 'employment_history'
  require_relative 'resume'
end
