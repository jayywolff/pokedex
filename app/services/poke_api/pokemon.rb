module PokeApi
  class Pokemon < Base
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
        @response = connection.get("pokemon/#{id}")
        if valid_response? && deserializer.valid?
          deserializer.deserialize(pokemon_species)
        else
          PokemonFetchError.new(error_message)
        end
      end
    end

  private
    def deserializer
      @deserializer ||= PokemonDeserializer.new(response.body)
    end

    def pokemon_species
      PokemonSpecies.fetch(id)
    end

    class PokemonFetchError < StandardError; end
  end
end
