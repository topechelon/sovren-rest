# frozen_string_literal: true

require 'base64'
require 'json'
require 'rest-client'

##
# A wrapper for interacting with the sovren
# resume parser REST api V9.
module SovrenRest
  require_relative 'sovren-rest/client'
  require_relative 'sovren-rest/parse_response'
  require_relative 'sovren-rest/resume'
  require_relative 'sovren-rest/exceptions'
end
