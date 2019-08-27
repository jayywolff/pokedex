# frozen_string_literal: true

module PokeApi
  class Base
    attr_reader :response

  protected
    def connection
      Connection.start
    end

    def valid_response?
      response.present? && response.success? && response.body.present?
    end

    def error_message
      message = "Status: #{response.status}\nErrors: "
      if response.present? && !response.success? && response.body.present?
        message << response.body
      elsif !deserializer.valid? && deserializer.errors.present?
        message << deserializer.errors
      else
        message << 'Failed to receive valid request from PokeApi'
      end
    end
  end
end
