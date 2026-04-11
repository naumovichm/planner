# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event#show', type: :feature do
  describe 'show event' do
    let(:user) { create(:user) }

    describe 'when user is authenticated' do
      before do
        login_as(user)
        create(:event, user: user)
        visit event_path(Event.first.id, locale: I18n.locale)
      end

      it { expect(page).to have_button('Delete') }
      it { expect(page).to have_link('Edit') }
    end

    describe 'when user is not authenticated' do
      before do
        create(:event)
        visit event_path(Event.first.id, locale: I18n.locale)
      end

      it { expect(page).to have_no_content('Event') }
    end
  end
end
