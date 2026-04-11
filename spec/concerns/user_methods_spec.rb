# frozen_string_literal: true

require 'spec_helper'

describe 'UserMethods' do
  describe '.user_include_category?' do
    let(:category) { create(:category) }
    let(:user) { create(:user) }
    let(:category_params) { { name: category.name } }

    it 'category include in user categories' do
      user.categories.push(category)
      expect(user.include_category?(category_params:)).to be true
    end

    it 'category not include in user categories' do
      expect(user.include_category?(category_params:)).to be false
    end
  end
end
