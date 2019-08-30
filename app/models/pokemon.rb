# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include ActiveModel::Serializers::JSON
  require 'csv'

  REGION = 'kanto'

  self.table_name = 'pokemon'

  validates :name, presence: true

  has_and_belongs_to_many :types

  def self.to_csv
    pokemon = all.as_json
    CSV.generate do |csv|
      csv << pokemon.first.keys
      pokemon.each do |p|
        p['types'] = p['types'].map { |type| type['name'] }.join(' / ')
        csv << p.values
      end
    end
  end

  def as_json
    serializable_hash(except: [:created_at, :updated_at], include: :types).as_json
  end
end
