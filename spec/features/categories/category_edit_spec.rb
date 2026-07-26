# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category edit', type: :feature do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let!(:category_work) { create(:category) }
  let!(:category_personal) { create(:category) }

  describe 'when user is authenticated' do
    before do
      create(:user_category, user:, category: category_work)
      login_as(user)
      visit edit_category_path(category_work.id, locale: I18n.locale)
    end

    describe 'error 404' do
      it { expect(page).to have_css('#error-id') }
    end
  end

  describe 'when admin is authenticated' do
    before do
      create(:user_category, user: admin, category: category_work)
      login_as(admin)
      visit edit_category_path(category_work.id, locale: I18n.locale)
    end

    describe 'name of category has already exist' do
      before do
        fill_in 'Name', with: category_personal.name
        click_button 'Create'
      end

      it { expect(page).to have_content('Name has already been taken') }
    end

    describe 'name of category is empty' do
      before do
        fill_in 'Name', with: ''
        click_button 'Create'
      end

      it { expect(page).to have_content("Name can't be blank") }
    end
  end

  describe 'when user is not authenticated' do
    before { visit edit_category_path(category_work.id, locale: I18n.locale) }

    it { expect(page).to have_no_content('Categories') }
    it { expect(page).to have_no_content('Category updated successfully') }
  end
end
