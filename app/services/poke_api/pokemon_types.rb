# frozen_string_literal: true

module PokeApi
  class PokemonTypes < Base
    def self.fetch(type = nil)
      new(type).fetch
    end

    attr_reader :type

    def initialize(type)
      @type = type
    end

    def fetch
      @response = connection.get("type#{'/' + type if type.present?}")
      if valid_response? && deserializer.valid?
        types = deserializer.deserialize
        types.each(&:save)
      else
        raise PokemonTypeFetchError.new(error_message)
      end
    end

  private
    def deserializer
      PokemonTypeDeserializer.new(type, response.body)
    end

    class PokedexFetchError < StandardError; end
  end
end
