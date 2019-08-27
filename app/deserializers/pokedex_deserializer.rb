# frozen_string_literal: true

class PokedexDeserializer < BaseDeserializer
  def deserialize
    data[:pokemon_entries].map { |entry| build_pokemon(entry) }
  end

  def required_keys
    [:pokemon_entries]
  end

private
  def build_pokemon(entry)
    Pokemon.new(
      id:   entry[:entry_number],
      name: entry[:pokemon_species][:name].titleize
    )
  end
end
