module PokeApi
  class Connection
    CACHE_EXPIRATION = 24.hours

    def self.start
      Faraday.new(url: 'https://pokeapi.co/api/v2') do |conn|
        conn.headers = { 'Content-Type' => 'application/json' }
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
