module PokeApi
  class Type < Base
    def self.fetch(type = nil)
      new(type).fetch
    end

    attr_reader :type

    def initialize(type)
      @type = type
    end

    def fetch
      cache_key = "#{self.class}/#{type if type.present?}"
      Rails.cache.fetch(cache_key, expires_in: Connection::CACHE_EXPIRATION) do
        @response = connection.get("type#{'/' + type if type.present?}")
        if valid_response? && deserializer.valid?
          deserializer.deserialize
        else
          PokemonTypeFetchError.new(error_message)
        end
      end
    end

  private
    def deserializer
      @deserializer ||= PokemonTypeDeserializer.new(type, response.body)
    end

    class PokedexFetchError < StandardError; end
  end
end
