module SovrenRest
  class << self
    def configure
      yield self
      true
    end
  require_relative "client"
  end
end