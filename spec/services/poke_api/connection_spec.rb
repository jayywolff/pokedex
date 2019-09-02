# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeApi::Connection do
  describe '.start' do
    it 'returns a Faraday::Connection instance with a url prefix pointing to the pokeapi v2' do
      connection = described_class.start
      expect(connection).to be_an_instance_of(Faraday::Connection)
      expect(connection.url_prefix.to_s).to eq 'https://pokeapi.co/api/v2'
      expect(connection.headers['Content-Type']).to eq 'application/json'
    end
  end
end
