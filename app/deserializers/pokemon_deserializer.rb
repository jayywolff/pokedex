# frozen_string_literal: true

class PokemonDeserializer < BaseDeserializer
  def deserialize(pokemon_species = nil)
    if pokemon_species.present?
      build_pokemon_with_species_attributes(pokemon_species)
    else
      build_pokemon
    end
  end

  def required_keys
    [:id, :name, :height, :weight, :sprites, :types]
  end

private
  def build_pokemon
    Pokemon.find_or_initialize_by(id: data[:id]) do |pokemon|
      pokemon.name   = data[:name].titleize
      pokemon.height = data[:height]
      pokemon.weight = data[:weight]
      pokemon.sprite = data[:sprites][:front_default]
      pokemon.types << deserialize_types
    end
  end

  def build_pokemon_with_species_attributes(pokemon_species)
    build_pokemon.tap do |pokemon|
      pokemon.attributes = pokemon_species.attributes.compact
    end
  end

  def deserialize_types
    data[:types].map do |type|
      key = type[:type][:name].titleize
      types[key]&.first
    end
  end

  def types
    @types ||= Type.all&.group_by(&:name)
  end
end
