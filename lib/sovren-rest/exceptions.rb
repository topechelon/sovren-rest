# frozen_string_literal: true

module SovrenRest
  #
  ## Errors unrelated to an officially documented Sovren response
  class ClientException < StandardError
    class RestClientTimeout < ClientException; end

    class GatewayTimeout < ClientException; end
  end
  
  #
  ## Errors parsing the json response from Sovren
  class ResponseParseError < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
      super('Error while parsing RestClient response')
    end
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

    def self.error_class_for_message(response_message)
      response_exception_code = ERROR_CODE_EXCEPTION_MAPPINGS.keys.find { |c| response_message.include?(c) }
      ERROR_CODE_EXCEPTION_MAPPINGS[response_exception_code]
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
  NO_TEXT_ERROR_CODE = 'ovNoText'
  IMAGE_ERROR_CODE = 'ovIsImage'
  TIMEOUT_ERROR_CODE = 'ovTimeout'
  CORRUPT_ERROR_CODE = 'ovCorrupt'
  UNSUPPORTED_FORMAT_ERROR_CODE = 'ovUnsupportedFormat'
  ENCRYPTED_ERROR_CODE = 'ovIsEncrypted'
  TEXT_CONVERSION_ERROR_CODE = 'ovErrorOnOutputToText'

  ERROR_CODE_EXCEPTION_MAPPINGS = {
    NO_TEXT_ERROR_CODE => SovrenRest::ConversionNoTextException,
    IMAGE_ERROR_CODE => SovrenRest::ConversionImageException,
    TIMEOUT_ERROR_CODE => SovrenRest::ConversionTimeoutException,
    CORRUPT_ERROR_CODE => SovrenRest::ConversionCorruptException,
    UNSUPPORTED_FORMAT_ERROR_CODE => SovrenRest::ConversionUnsupportedFormatException,
    ENCRYPTED_ERROR_CODE => SovrenRest::ConversionEncryptedException,
    TEXT_CONVERSION_ERROR_CODE => SovrenRest::ConversionToOutputTextException
  }.freeze
end
