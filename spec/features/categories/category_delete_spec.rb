# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category delete', type: :feature do
  describe 'delete category' do
    let(:user) { create(:user) }

    describe 'when user is authenticated' do
      let(:category_work) { create(:category, :work) }

      before do
        create(:user_category, user:, category: category_work)
        login_as(user)
        visit categories_path
        within('.table') do
          click_button 'Delete'
        end
      end

      it { expect(page).to have_content('Category successfully deleted') }
      it { expect(page).to have_content('No Categories') }
    end

    describe 'when user is not authenticated' do
      before { visit categories_path }

      it { expect(page).to have_no_content('Category successfully deleted') }
    end
  end
end
