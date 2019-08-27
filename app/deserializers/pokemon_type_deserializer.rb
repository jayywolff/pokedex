class PokemonTypeDeserializer < BaseDeserializer
  def initialize(type, json)
    @type = type
    super(json)
  end

  def deserialize
    list_of_types? ? deserialize_types_list : build_pokemon_type(data)
  end

  def required_keys
    return [:results] if list_of_types?
    [:id, :name]
  end

private
  def list_of_types?
    @type.nil?
  end

  def deserialize_types_list
    data[:results].map { |hash| build_pokemon_type(hash) }
  end

  def build_pokemon_type(hash)
    id = hash[:url].split('/').last
    Type.find_or_initialize_by(id: id) do |type|
      type.name = hash[:name].titleize
    end
  end
end
