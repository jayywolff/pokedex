# frozen_string_literal: true

module Reports
  class PokemonReport < Base
    def self.generate
      pokemon = Pokemon.all.as_json.each do |p|
        p['types'] = p['types'].map { |type| type['name'] }.join(' / ')
      end

      super(pokemon)
    end
  end
end
