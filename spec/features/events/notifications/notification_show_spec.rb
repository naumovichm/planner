# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notification#show', type: :feature do
  describe 'show event' do
    let(:user) { create(:user) }
    let(:notification) { create(:notification, user: user) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        create(:notification, user: user)
        visit events_notification_path(Notification.first.id, locale: I18n.locale)
      end

      it { expect(page).to have_button('Delete') }
      it { expect(page).to have_link('Edit') }
    end

    describe 'when user is not authenticated' do
      before do
        create(:notification)
        visit events_notification_path(Notification.first.id, locale: I18n.locale)
      end

      it { expect(page).to have_no_content('Event') }
    end
  end
end
