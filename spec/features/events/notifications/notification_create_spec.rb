# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event create', type: :feature do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:notification) { build(:notification) }

  describe 'when user is authenticated' do
    before do
      create(:user_category, user:, category:)
      login_as(user)
      visit new_events_notification_path
    end

    describe 'create event' do
      before do
        fill_in 'Name', with: notification.name
        fill_in 'Event date', with: notification.event_date
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content('Event successfully created') }
      it { expect(page).to have_content(notification.name) }
      it { expect(page).to have_content(category.name) }
    end

    describe 'name of event is empty' do
      before do
        fill_in 'Event date', with: notification.event_date
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Name can't be blank") }
    end

    describe 'event date is empty' do
      before do
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Event date can't be blank") }
    end

    describe 'event date is in the past' do
      before do
        fill_in 'Event date', with: DateTime.now.yesterday
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Event date can't be in the past") }
    end

    describe 'reminder_on is in the past' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow
        fill_in 'Reminder on', with: DateTime.now.yesterday
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be in the past") }
    end

    describe 'reminder_on is greater than event_date' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow
        fill_in 'Reminder on', with: DateTime.now.tomorrow + 1.minute
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be equal or greater than event date") }
    end

    describe 'reminder_on is equal to event_date' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow
        fill_in 'Reminder on', with: DateTime.now.tomorrow
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        select category.name, from: 'Category select'
        click_button 'Create'
      end

      it { expect(page).to have_content("Reminder on can't be equal or greater than event date") }
    end

    describe 'category is empty' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow + 1.day
        fill_in 'Reminder on', with: DateTime.now.tomorrow
        fill_in 'Name', with: notification.name
        fill_in 'Notification text', with: notification.notification_text
        click_button 'Create'
      end

      it { expect(page).to have_content('Category must exist') }
    end

    describe 'notification text is empty' do
      before do
        fill_in 'Event date', with: DateTime.now.tomorrow + 1.day
        fill_in 'Reminder on', with: DateTime.now.tomorrow
        fill_in 'Name', with: notification.name
        click_button 'Create'
      end

      it { expect(page).to have_content("Notification text can't be blank") }
    end
  end

  describe 'when user is not authenticated' do
    before do
      create(:user_category, user:, category:)
      visit new_events_notification_path
    end

    it { expect(page).to have_no_content('Event successfully created') }
    it { expect(page).to have_no_content(notification.name) }
    it { expect(page).to have_no_content(category.name) }
  end
end
