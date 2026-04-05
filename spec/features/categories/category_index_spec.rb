# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category categories', type: :feature do
  describe 'categories category' do
    let(:user) { create(:user) }
    let(:category_work) { create(:category, :work) }

    describe 'when user is authenticated' do
      before do
        create(:user_category, user:, category: category_work)
        login_as(user)
        visit categories_path
      end

      it { expect(page).to have_content('Categories') }
      it { expect(page).to have_content(category_work.name) }
      it { expect(page).to have_button('Delete') }
    end

    describe 'when user is not authenticated' do
      before { visit categories_path }

      it { expect(page).to have_no_content('Categories') }
      it { expect(page).to have_no_content(category_work.name) }
    end
  end
end
