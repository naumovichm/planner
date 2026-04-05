# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { build(:category) }

  context 'when category is valid' do
    it { expect(category).to be_valid }
  end

  describe 'validations' do
    it { expect(category).to validate_presence_of :name }

    describe 'uniqueness validation' do
      subject(:category) { create(:category) }

      it { expect(category).to validate_uniqueness_of(:name).case_insensitive }
    end
  end

  describe 'traits' do
    context "when name of category is 'Vacation'" do
      let(:category_vacation) { build(:category, :vacation) }

      it { expect(category_vacation.name).to eql 'Vacation' }
    end

    context "when name of category is 'Personal'" do
      let(:category_personal) { build(:category, :personal) }

      it { expect(category_personal.name).to eql 'Personal' }
    end

    context "when name of category is 'Work'" do
      let(:category_work) { build(:category, :work) }

      it { expect(category_work.name).to eql 'Work' }
    end
  end

  describe 'associations' do
    it { expect(category).to have_many(:events).dependent(:destroy) }
    it { expect(category).to have_many(:user_categories).dependent(:destroy) }
    it { expect(category).to have_many(:users).through(:user_categories) }
  end
end
