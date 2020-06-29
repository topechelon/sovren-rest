module SovrenRest
  #
  ## Errors unrelated to an officially documented Sovren response
  class ClientException < StandardError
    class RestClientTimeout < ClientException; end
    class GatewayTimeout < ClientException; end
  end

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
      error_class = error_class_for_message(message)
      error_class ||= SovrenRest::ERROR_CODE_CLASSES[code]
      error_class ||= SovrenRest::ParsingError
      error_class.new(message, code: code)
    end

    def self.contains_error_code?(error_code)
      ->(response) { response.include?(error_code) }
    end

    def self.error_class_for_message(response_message)
      case response_message
      when contains_error_code?(NO_TEXT_ERROR_CODE)
        SovrenRest::ConversionNoTextException
      when contains_error_code?(IMAGE_ERROR_CODE)
        SovrenRest::ConversionImageException
      when contains_error_code?(TIMEOUT_ERROR_CODE)
        SovrenRest::ConversionTimeoutException
      when contains_error_code?(CORRUPT_ERROR_CODE)
        SovrenRest::ConversionCorruptException
      when contains_error_code?(UNSUPPORTED_FORMAT_ERROR_CODE)
        SovrenRest::ConversionUnsupportedFormatException
      when contains_error_code?(ENCRYPTED_ERROR_CODE)
        SovrenRest::ConversionEncryptedException
      when contains_error_code?(TEXT_CONVERSION_ERROR_CODE)
        SovrenRest::ConversionToOutputTextException
      end
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
  class ConversionNoTextException < ConversionException; end
  class ConversionTimeoutException < ConversionException; end
  class ConversionImageException < ConversionException; end
  class ConversionCorruptException < ConversionException; end
  class ConversionUnsupportedFormatException < ConversionException; end
  class ConversionEncryptedException < ConversionException; end
  class ConversionToOutputTextException < ConversionException; end

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
    'ConversionException' => SovrenRest::ConversionException
  }.freeze

  # https://documentation.sovren.com/#document-conversion-result-codes
  NO_TEXT_ERROR_CODE = 'ovNoText'.freeze
  IMAGE_ERROR_CODE = 'ovIsImage'.freeze
  TIMEOUT_ERROR_CODE = 'ovTimeout'.freeze
  CORRUPT_ERROR_CODE = 'ovCorrupt'.freeze
  UNSUPPORTED_FORMAT_ERROR_CODE = 'ovUnsupportedFormat'.freeze
  ENCRYPTED_ERROR_CODE = 'ovIsEncrypted'.freeze
  TEXT_CONVERSION_ERROR_CODE = 'ovErrorOnOutputToText'.freeze
end
