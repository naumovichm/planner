# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meeting#show', type: :feature do
  describe 'show event' do
    let(:user) { create(:user) }
    let(:meeting) { create(:meeting, user: user) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        visit events_meeting_path(meeting.id, locale: I18n.locale)
      end

      it { expect(page).to have_button('Delete') }
      it { expect(page).to have_link('Edit') }
    end

    describe 'when user is not authenticated' do
      before do
        visit events_meeting_path(meeting.id, locale: I18n.locale)
      end

      it { expect(page).to have_no_content('Event') }
    end
  end
end
