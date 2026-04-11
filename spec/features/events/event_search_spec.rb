# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search&filter', type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'search and filter' do
    let!(:event_one) { create(:event, user:, category:, name: 'One') }
    let!(:event_two) { create(:event, user:, category:, name: 'Two') }

    before do
      create(:user_category, user:, category:)
      login_as(user)
      visit events_path
    end

    context 'when search by name' do
      before do
        fill_in 'Search', with: event_one.name
        click_button 'Search'
      end

      it { expect(page).to have_content(event_one.name) }
      it { expect(page).not_to have_content(event_two.name) }
    end

    context 'when search by category' do
      before do
        select category.name, from: 'Category select'
        click_button 'Search'
      end

      it { expect(page).to have_content(event_one.name) }
      it { expect(page).to have_content(event_two.name) }
    end

    context 'when search by name and by category' do
      before do
        fill_in 'Search', with: event_two.name
        select category.name, from: 'Category select'
        click_button 'Search'
      end

      it { expect(page).not_to have_content(event_one.name) }
      it { expect(page).to have_content(event_two.name) }
    end

    context 'when search by unknown name' do
      before do
        fill_in 'Search', with: 'unknown name'
        click_button 'Search'
      end

      it { expect(page).to have_content('No Events') }
      it { expect(page).not_to have_content(event_one.name) }
      it { expect(page).not_to have_content(event_two.name) }
    end
  end
end
