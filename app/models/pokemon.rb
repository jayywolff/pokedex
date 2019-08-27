# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActiveModel::Serializers::JSON

  REGION = 'kanto'

  attr_reader :region, :resource_url

  self.table_name = 'pokemon'

  has_and_belongs_to_many :types

  validates :name, presence: true

  def region
    REGION.titleize
  end
end
