# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event#index', type: :feature do
  describe 'index event' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    describe 'when user is authenticated' do
      let!(:events) { create_list(:event, 5, user:, category:) }

      before do
        login_as(user)
        visit events_path
      end

      it { expect(page).to have_content('Events') }
      it { expect(page).to have_link('Add') }

      it 'include user events' do
        events.each do |event|
          expect(page).to have_content(event.name)
        end
      end
    end

    describe 'when user is not authenticated' do
      before { visit events_path }

      it { expect(page).to have_no_content('Events') }
    end
  end
end
