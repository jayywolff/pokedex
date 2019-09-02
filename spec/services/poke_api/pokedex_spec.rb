# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeApi::Pokedex do
  let(:region)        { 'kanto' }
  let(:connection)    { double(:connection) }
  let(:response)      { double(:response, status: 200, success?: true, body: response_body) }
  let(:response_body) { file_fixture('kanto_pokedex_response.json').read }

  subject { described_class.new(region) }

  before { allow(PokeApi::Connection).to receive(:start).and_return connection }

  describe '#fetch' do
    context 'PokeApi returns a successful response with a valid body' do
      it 'returns the deserialized json response as an array of Pokemon' do
        expect(connection).to receive(:get).with("pokedex/#{region}").and_return response

        pokedex = subject.fetch

        expect(pokedex.count).to eq 151
        pokedex.each do |pokemon|
          expect(pokemon).to be_an_instance_of Pokemon
          expect(pokemon.id.present?).to be true
          expect(pokemon.name.present?).to be true
        end
      end
    end

    context 'PokeApi returns a successful response with an invalid body' do
      let(:response) { double(:response, status: 200, success?: true, body: '') }
      let(:message)  { "Status: #{response.status}\nErrors: Failed to receive valid request from PokeApi" }

      it 'throws an error with a message including the status code' do
        expect(connection).to receive(:get).with("pokedex/#{region}").and_return response
        expect { subject.fetch }.to raise_error(PokeApi::PokedexFetchError, message)
      end
    end

    context 'PokeApi returns an unsuccessful response' do
      let(:response) { double(:response, status: 422, success?: false, body: 'Your request sucks') }
      let(:message)  { "Status: #{response.status}\nErrors: #{response.body}" }

      it 'throws an error with a message including the status code and response body' do
        expect(connection).to receive(:get).with("pokedex/#{region}").and_return response
        expect { subject.fetch }.to raise_error(PokeApi::PokedexFetchError, message)
      end
    end
  end
end
