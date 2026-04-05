# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :model do
  subject(:user) { build(:user) }

  context 'when user is valid' do
    it { expect(user).to be_valid }
  end

  describe 'validations' do
    it { expect(user).to validate_presence_of :first_name }
    it { expect(user).to validate_presence_of :email }
    it { expect(user).to validate_presence_of :password }

    describe 'uniqueness validation' do
      subject(:user) { create(:user) }

      it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe 'traits' do
    describe 'user with last_name' do
      let(:user_with_last_name) { build(:user, :with_last_name) }

      it { expect(user_with_last_name.last_name).to be_a(String) }
    end
  end

  describe 'associations' do
    it { expect(user).to have_many(:events).dependent(:destroy) }
    it { expect(user).to have_many(:user_categories).dependent(:destroy) }
    it { expect(user).to have_many(:categories).through(:user_categories) }
  end
end
