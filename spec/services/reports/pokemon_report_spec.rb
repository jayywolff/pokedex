# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::PokemonReport do
  let(:pokemon) { [charmander, charizard] }
  let(:charmander) do
    build(:pokemon,
      id:           4,
      name:         'Charmander',
      height:       6,
      weight:       85,
      sprite:       'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      shape:        'Upright',
      capture_rate: 17.65,
      types:        [build(:type, id: 10, name: 'Fire')]
    )
  end
  let(:charizard) do
    build(:pokemon,
      id:           6,
      name:         'Charizard',
      height:       17,
      weight:       905,
      sprite:       'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png',
      shape:        'Upright',
      capture_rate: 17.65,
      types:        [build(:type, id: 3, name: 'Flying'), build(:type, id: 10, name: 'Fire')]
    )
  end

  describe '.generate' do
    it 'generates a csv report of all the pokemon' do
      allow(Pokemon).to receive(:all).and_return pokemon
      expect(described_class.generate).to eq <<~CSV
        id,name,height,weight,sprite,shape,capture_rate,types
        4,Charmander,6,85,https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png,Upright,17.65,Fire
        6,Charizard,17,905,https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png,Upright,17.65,Flying / Fire
      CSV
    end
  end
end
