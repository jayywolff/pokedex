# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include ActiveModel::Serializers::JSON

  REGION = 'kanto'

  self.table_name = 'pokemon'

  validates :name, presence: true

  has_and_belongs_to_many :types

  def as_json
    serializable_hash(except: [:created_at, :updated_at], include: :types).as_json
  end
end
