require 'rest-client'

module SovrenRest
  class << self
    FIELDS = [:endpoint, :username, :password, :timeout, :hard_time_out_multiplier,
      :parser_configuration_params
    ]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end
  end

  require_relative "client"
end