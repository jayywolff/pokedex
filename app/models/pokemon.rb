class Pokemon
  include Rails.application.routes.url_helpers

  REGION = 'kanto'

  attr_accessor(
    :id,
    :name,
    :type,
    :capture_rate,
    :shape,
    :sprite,
    :link
  )

  def initialize(id: nil, name: nil, type: nil, capture_rate: nil, shape: nil, sprite: nil)
    @id           = id
    @name         = name
    @type         = type
    @capture_rate = capture_rate
    @shape        = shape
    @sprite       = sprite || default_image
    @link         = path
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

  def path
    return if id.nil?
    pokemon_path id
  end
end
