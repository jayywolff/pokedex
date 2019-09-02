# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:types) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#as_json' do
    let(:types) { [build(:type, id: 10, name: 'Fire')] }
    let(:pokemon) do
      build(:pokemon,
        id:           4,
        name:         'Charmander',
        height:       6,
        weight:       85,
        sprite:       'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
        shape:        'Upright',
        capture_rate: 17.65,
        types:        types
      )
    end

    it 'returns a serialized hash with the pokemon attributes excluding the timestamps' do
      expect(pokemon.as_json).to match ({
        'id'           => 4,
        'name'         => 'Charmander',
        'height'       => 6,
        'weight'       => 85,
        'sprite'       => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
        'shape'        => 'Upright',
        'capture_rate' => '17.65',
        'types'        => [{ 'id' => 10, 'name' => 'Fire' }]
      })
    end
  end
end
