# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActiveModel::Serializers::JSON
  require 'csv'

  REGION = 'kanto'

  attr_reader :region, :resource_url

  self.table_name = 'pokemon'

  has_and_belongs_to_many :types

  validates :name, presence: true

  def self.to_csv
    CSV.generate do |csv|
      data = all.as_json
      csv << data.first.keys
      data.each do |p|
        p['types'] = p['types'].map { |type| type['name'] }.join(' / ')
        csv << p.values
      end
    end
  end

  def as_json
    serializable_hash(
      except: [:created_at, :updated_at], include: :types
    ).as_json
  end

  def to_xml
    as_json.to_xml
  end

  def region
    REGION.titleize
  end
end
