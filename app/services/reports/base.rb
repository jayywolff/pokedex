# frozen_string_literal: true

module Reports
  class Base
    require 'csv'

    attr_reader :data

    def self.generate(data)
      new(data).generate
    end

    def initialize(data)
      @data = data
    end

    def generate
      CSV.generate do |csv|
        csv << data.first.keys
        data.each { |row| csv << row.values }
      end
    end
  end
end
