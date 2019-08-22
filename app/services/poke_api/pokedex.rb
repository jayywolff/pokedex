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
      cache_key = "#{self.class}/#{region}"
      Rails.cache.fetch(cache_key, expires_in: Connection::CACHE_EXPIRATION) do
        @response = connection.get("pokedex/#{region}")
        if valid_response? && deserializer.valid?
          deserializer.deserialize
        else
          PokedexFetchError.new(error_message)
        end
      end
    end

  private
    def deserializer
      @deserializer ||= PokedexDeserializer.new(response.body)
    end

    class PokedexFetchError < StandardError; end
  end
end
