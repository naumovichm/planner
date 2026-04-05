# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event#edit', type: :feature do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }

  let!(:event) { create(:event, user:, category:) }

  describe 'when user is authenticated' do
    before do
      create(:user_category, user:, category:)
      login_as(user)
      visit edit_event_path(event.id, locale: I18n.locale)
    end

    describe 'edit event' do
      before do
        fill_in 'Name', with: 'NewName'
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content('Event updated successfully') }
    end

    describe 'when name is empty' do
      before do
        fill_in 'Name', with: nil
        click_button 'Create'
      end

      it { expect(page).to have_content("Name can't be blank") }
    end

    describe 'when event date is empty' do
      before do
        fill_in 'Event date', with: nil
        click_button 'Create'
      end

      it { expect(page).to have_content("Event date can't be blank") }
    end

    describe 'when event date is in the past' do
      before do
        fill_in 'Event date', with: DateTime.now.yesterday
        click_button 'Create'
      end

      it { expect(page).to have_content("Event date can't be in the past") }
    end

    describe 'when reminder_on is in the past' do
      before do
        fill_in 'Reminder on', with: DateTime.now.yesterday
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be in the past") }
    end

    describe 'when reminder_on is greater than event_date' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow
        fill_in 'Reminder on', with: DateTime.now.tomorrow + 1.minute
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be equal or greater than event date") }
    end

    describe 'when reminder_on is equal to event_date' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow
        fill_in 'Reminder on', with: DateTime.now.tomorrow
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be equal or greater than event date") }
    end
  end

  describe 'when user is not authenticated' do
    before do
      create(:user_category, user:, category:)
      visit edit_event_path(event.id, locale: I18n.locale)
    end

    it { expect(page).to have_no_content('Event successfully updated') }
  end
end
