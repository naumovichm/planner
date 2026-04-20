# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  subject(:user_category) { build(:user_category) }

  context 'when user_category is valid' do
    it { expect(user_category).to be_valid }
  end

  describe 'associations' do
    it { expect(user_category).to belong_to(:user).dependent(:destroy) }
    it { expect(user_category).to belong_to(:category).dependent(:destroy) }
  end
end
