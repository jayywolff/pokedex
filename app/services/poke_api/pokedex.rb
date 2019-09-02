# frozen_string_literal: true

module PokeApi
  class Pokedex < Base
    def self.fetch(region)
      new(region).fetch
    end

    attr_reader :region

    def initialize(region)
      @region = region
    end

    def fetch
      @response = connection.get("pokedex/#{region}")
      if valid_response? && deserializer.valid?
        deserializer.deserialize
      else
        raise PokedexFetchError.new(error_message)
      end
    end

  private

    def deserializer
      PokedexDeserializer.new(response.body)
    end
  end
  class PokedexFetchError < StandardError; end
end
