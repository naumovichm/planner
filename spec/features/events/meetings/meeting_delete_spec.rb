# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meeting#delete', type: :feature do
  describe 'delete event' do
    let(:user) { create(:user) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        create(:meeting, user:)
        visit events_meeting_path(Meeting.first.id, locale: I18n.locale)
        click_button 'Delete'
      end

      it { expect(page).to have_content('Event successfully deleted') }
    end

    describe 'when user is not authenticated' do
      before do
        create(:meeting, user:)
        visit events_meeting_path(Meeting.first.id, locale: I18n.locale)
      end

      it { expect(page).to have_no_content('Event successfully deleted') }
    end
  end
end
