# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category show', type: :feature do
  describe 'show category' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let!(:category) { create(:category) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        create(:user_category, user:, category:)
        visit category_path(category, locale: I18n.locale)
      end

      describe 'error 403' do
        it { expect(page.status_code).to eq(403) }
      end
    end

    describe 'when admin is authenticated' do
      before do
        login_as(admin)
        create(:user_category, user: admin, category:)
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
