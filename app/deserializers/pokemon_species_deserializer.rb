class PokemonSpeciesDeserializer < BaseDeserializer
  def deserialize
    build_pokemon
  end

  def required_keys
    [:id, :shape, :capture_rate]
  end

private
  def build_pokemon
    Pokemon.new(
      id:           data[:id],
      shape:        data[:shape][:name].titleize,
      capture_rate: data[:capture_rate]
    )
  end
end
