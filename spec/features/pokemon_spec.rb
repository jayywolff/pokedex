require 'rails_helper'

RSpec.feature "Pokemon", type: :feature do
  describe '#index' do
    scenario "index displays a table of the OG Kanto pokemon" do
      visit "/pokemon"
      expect(page).to have_css('tr.pokemon', count: 151)
    end
  end
end
