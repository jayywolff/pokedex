class BaseDeserializer
  include ActiveModel::Validations
  attr_reader :data

  validate :required_keys_present?

  def initialize(json)
    @data = JSON.parse(json).deep_symbolize_keys
  end

  def deserialize
    StandardError.new("Deserialize not implemented, can't deserialize from #{this.class.name}")
  end

  def required_keys
    []
  end

protected
  def required_keys_present?
    missing = required_keys - data.keys
    missing.each { |key| errors.add(key.to_sym, 'was not sent') }
    missing.empty?
  end
end
