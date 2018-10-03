# A wrapper for interacting with the sovren
# resume parser REST api V9
module SovrenRest
  class << self
    def configure
      yield self
      true
    end
    require_relative 'client'
  end
end
