# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category show', type: :feature do
  describe 'show category' do
    let(:user) { create(:user) }
    let!(:category) { create(:category) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        create(:user_category, user:, category:)
        visit category_path(category, locale: I18n.locale)
      end

      it { expect(page).to have_content('Category') }
      it { expect(page).to have_content(category.name) }
      it { expect(page).to have_button('Delete') }
      it { expect(page).to have_link('Edit') }
    end

    describe 'when user is not authenticated' do
      before { visit category_path(category, locale: I18n.locale) }

      it { expect(page).to have_no_content('Category') }
      it { expect(page).to have_no_content(category.name) }
    end
  end
end
