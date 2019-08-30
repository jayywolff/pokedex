# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:pokemon) }
  end
end
