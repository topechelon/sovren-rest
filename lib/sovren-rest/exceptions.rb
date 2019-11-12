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

    def self.for(message, code: nil)
      error_class = SovrenRest::ERROR_MESSAGE_CLASSES[message]
      error_class ||= SovrenRest::ERROR_CODE_CLASSES[code]
      error_class ||= SovrenRest::ParsingError
      error_class.new(message, code: code)
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
  class RestClientTimeout < ParsingError; end
  class ConversionException < ParsingError; end
  class ConversionNoTextException < ConversionException; end
  class ConversionTimeoutException < ConversionException; end

  ##
  # https://documentation.sovren.com/API/Rest#http-status-codes
  ERROR_CODE_CLASSES = {
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
    'ConversionException' => SovrenRest::ConversionException,
    'RestClientTimeout' => SovrenRest::RestClientTimeout
  }.freeze

  ERROR_MESSAGE_CLASSES = {
    'Failed to convert document - ovNoText' => SovrenRest::ConversionNoTextException, # rubocop:disable Metrics/LineLength
    'Failed to convert document - ovTimeout' => SovrenRest::ConversionTimeoutException # rubocop:disable Metrics/LineLength
  }.freeze
end
