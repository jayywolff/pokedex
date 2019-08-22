class PokemonTypeDeserializer < BaseDeserializer
  def initialize(type, json)
    @type = type
    super(json)
  end

  def deserialize
    list_of_types? ? deserialize_types_list : deserialize_type
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
    data[:results].map { |type| type[:name].titleize }.sort
  end

  def deserialize_type
    OpenStruct.new(
      id:   data[:id],
      name: data[:name].titleize
    )
  end
end
