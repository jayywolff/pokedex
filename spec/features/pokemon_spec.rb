# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Pokemon", type: :feature do
  describe '#index' do
    scenario "index displays a table of the OG Kanto pokemon", js: true do
      PokeApi::PokemonTypes.fetch
      # for test performance we only seed a few pokemon and assert they are displayed
      (1..4).each { |counter| PokeApi::Pokemon.fetch(counter) }

      visit "/pokemon"
      sleep 2

      expect(page).to have_css('tr td.pokemon-id', count: 4)
    end

    scenario "user can search pokemon by name", js: true do
      PokeApi::PokemonTypes.fetch
      (1..6).each { |counter| PokeApi::Pokemon.fetch(counter) }

      visit "/pokemon"
      sleep 2

      fill_in 'name-filter', with: 'char'

      expect(page).to have_css('tr td.pokemon-id', count: 3)
      expect(page).to have_content('Charmander')
      expect(page).to have_content('Charmeleon')
      expect(page).to have_content('Charizard')
    end

    scenario "user can filter pokemon by type", js: true do
      PokeApi::PokemonTypes.fetch
      (1..6).each { |counter| PokeApi::Pokemon.fetch(counter) }

      visit "/pokemon"
      sleep 2

      expect(page).to have_css('tr td.pokemon-id', count: 6)

      select 'Fire', from: 'type-filter'
      expect(page).to have_css('tr td.pokemon-id', count: 3)
      expect(page).to have_content('Charmander')
      expect(page).to have_content('Charmeleon')
      expect(page).to have_content('Charizard')

      select 'Grass', from: 'type-filter'
      expect(page).to have_css('tr td.pokemon-id', count: 3)
      expect(page).to have_content('Bulbasaur')
      expect(page).to have_content('Ivysaur')
      expect(page).to have_content('Venusaur')

      select 'All', from: 'type-filter'
      expect(page).to have_css('tr td.pokemon-id', count: 6)
    end
  end

  describe '#show' do
    scenario "show displays a description of a pokemon" do
      PokeApi::PokemonTypes.fetch
      PokeApi::Pokemon.fetch(4)

      visit "/pokemon/4"

      expect(page).to have_title('Pokedex #4 - Charmander')
      expect(page).to have_content('4')
      expect(page).to have_content('Charmander')
      expect(page).to have_content('Fire')
      expect(page).to have_content('Upright')
      expect(page).to have_content('85 hectograms')
      expect(page).to have_content('6 decimetres')
      expect(page).to have_content('17.65%')
    end
  end
end
