# frozen_string_literal: true

module PokeApi
  class Connection
    def self.start
      Faraday.new(url: 'https://pokeapi.co/api/v2') do |conn|
        conn.headers = { 'Content-Type' => 'application/json' }
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
