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
    Pokemon.new(
      id:       data[:id],
      name:     data[:name].titleize,
      height:   data[:height],
      weight:   data[:weight],
      sprite:   data[:sprites][:front_default],
      type:     deserialize_types
    )
  end

  def build_pokemon_with_species_attributes(pokemon_species)
    build_pokemon.tap do |pokemon|
      pokemon.attributes = pokemon_species.attributes.compact
    end
  end

  def deserialize_types
    data[:types].map { |type| type[:type][:name].titleize }
  end
end
