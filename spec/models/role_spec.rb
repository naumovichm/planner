# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { build(:role) }

  context 'when role is valid' do
    it { expect(role).to be_valid }
  end

  describe 'validations' do
    it { expect(role).to validate_presence_of :name }

    describe 'uniqueness validation' do
      subject(:role) { create(:role) }

      it { expect(role).to validate_uniqueness_of(:name).case_insensitive }
    end
  end

  describe 'association' do
    it { expect(role).to have_many(:users).dependent(:destroy) }
  end
end
