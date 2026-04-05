# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category create', type: :feature do
  let(:user) { create(:user) }

  describe 'when user is authenticated' do
    let(:category) { build(:category, :work) }

    before do
      login_as(user)
      visit new_category_path
    end

    describe 'create category' do
      before do
        fill_in 'Name', with: category.name
        click_button 'Create'
      end

      it { expect(page).to have_content('Category') }
      it { expect(page).to have_content('Category successfully created') }
      it { expect(page).to have_content('Work') }
    end

    describe 'name of category has already been taken' do
      let(:category_work) { create(:category, :work) }

      before do
        create(:user_category, user:, category: category_work)
        fill_in 'Name', with: category_work.name
        click_button 'Create'
      end

      it { expect(page).to have_content('Name has already been taken') }
    end
  end

  describe 'when user is not authenticated' do
    before { visit new_category_path }

    it { expect(page).to have_no_content('Category') }
  end
end
