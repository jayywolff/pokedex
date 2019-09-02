# frozen_string_literal: true

module PokeApi
  class Pokemon < Base
    def self.fetch(id)
      new.fetch(id)
    end

    def self.fetch_by_region(region)
      new(region).fetch_by_region
    end

    attr_reader :region

    def initialize(region = nil)
      @region = region
    end

    def fetch(id)
      @response = connection.get("pokemon/#{id}")
      if valid_response? && deserializer.valid?
        pokemon = deserializer.deserialize(pokemon_species(id))
        pokemon.save
      else
        raise PokemonFetchError.new(error_message)
      end
    end

    def fetch_by_region
      pokemon_entries.map do |id|
        fetch(id)
        sleep(1) # slow down process due to pokeapi.co 100 requests/min limit
      end
    end

  private
    def deserializer
      PokemonDeserializer.new(response.body)
    end

    def pokemon_species(id)
      PokemonSpecies.fetch(id)
    end

    def pokemon_entries
      Pokedex.fetch(region).map(&:id)
    end

    class PokemonFetchError < StandardError; end
  end
end
