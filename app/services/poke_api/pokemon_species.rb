# frozen_string_literal: true

module PokeApi
  class PokemonSpecies < Base
    def self.fetch(id)
      new(id).fetch
    end

    attr_reader :id

    def initialize(id)
      @id = id
    end

    def fetch
      @response = connection.get("pokemon-species/#{id}")
      if valid_response? && deserializer.valid?
        deserializer.deserialize
      else
        raise PokemonSpeciesFetchError.new(error_message)
      end
    end

  private
    def deserializer
      PokemonSpeciesDeserializer.new(response.body)
    end

    class PokemonSpeciesFetchError < StandardError; end
  end
end
