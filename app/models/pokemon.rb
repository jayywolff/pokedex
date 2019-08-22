class Pokemon
  REGION = 'kanto'

  attr_accessor(
    :id,
    :name,
    :type,
    :capture_rate,
    :shape,
    :icon,
    :sprite
  )

  def initialize(id:, name:, type: nil, capture_rate: nil, shape: nil, icon: nil, sprite: nil)
    @id           = id
    @name         = name
    @type         = type
    @capture_rate = capture_rate
    @shape        = shape
    @icon         = icon
    @sprite       = sprite || default_image
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end

  def region
    REGION.titleize
  end

  def default_image
    return if id.nil?
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{id}.png"
  end

  def link
    return if id.nil?
    "https://pokeapi.co/api/v2/pokemon/#{id}"
  end
end
