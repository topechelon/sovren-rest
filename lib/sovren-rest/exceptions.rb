module SovrenRest
  #
  ## Custom error encapsulating erroneous Sovren responses
  class ParsingError < StandardError
    attr_reader :response, :code

    def initialize(response, code: nil)
      @response = response
      @code = code
      super(response)
    end
  end

  class MissingParameter < ParsingError; end
  class InvalidParameter < ParsingError; end
  class InsufficientData < ParsingError; end
  class DataNotFound < ParsingError; end
  class CoordinatesNotFound < ParsingError; end
  class ConstraintError < ParsingError; end
  class AuthenticationError < ParsingError; end
  class Unauthorized < ParsingError; end
  class DataNotFound < ParsingError; end
  class DuplicateAsset < ParsingError; end
  class UnhandledException < ParsingError; end
  class ConversionException < ParsingError; end

  ##
  # https://documentation.sovren.com/API/Rest#http-status-codes
  ERROR_CLASSES = {
    'MissingParameter' => SovrenRest::MissingParameter,
    'InvalidParameter' => SovrenRest::InvalidParameter,
    'InsufficientData' => SovrenRest::InsufficientData,
    'DataNotFound' => SovrenRest::DataNotFound,
    'CoordinatesNotFound' => SovrenRest::CoordinatesNotFound,
    'ConstraintError' => SovrenRest::ConstraintError,
    'AuthenticationError' => SovrenRest::AuthenticationError,
    'Unauthorized' => SovrenRest::Unauthorized,
    'DuplicateAsset' => SovrenRest::DuplicateAsset,
    'UnhandledException' => SovrenRest::UnhandledException,
    'ConversionException' => SovrenRest::ConversionException
  }.freeze
end
