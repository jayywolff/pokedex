# frozen_string_literal: true

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
      capture_rate: capture_rate_percentage
    )
  end

  def capture_rate_percentage
    ((data[:capture_rate].to_f / 255) * 100).round(2)
  end
end
