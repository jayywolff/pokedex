# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::Base do
  let(:data) do
    [
      { id: 1, first_name: 'Rick', last_name: 'Sanchez' },
      { id: 2, first_name: 'Morty', last_name: 'Smith' }
    ]
  end

  subject { described_class.new(data) }

  describe '#generate' do
    it 'generates a csv report given an array of hashes' do
      expect(subject.generate).to eq (
        "id,first_name,last_name\n1,Rick,Sanchez\n2,Morty,Smith\n"
      )
    end
  end
end
