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
      cache_key = "#{self.class}/#{id}"
      Rails.cache.fetch(cache_key, expires_in: Connection::CACHE_EXPIRATION) do
        @response = connection.get("pokemon-species/#{id}")
        if valid_response? && deserializer.valid?
          deserializer.deserialize
        else
          PokemonSpeciesFetchError.new(error_message)
        end
      end
    end

  private
    def deserializer
      @deserializer ||= PokemonSpeciesDeserializer.new(response.body)
    end

    class PokemonSpeciesFetchError < StandardError; end
  end
end
