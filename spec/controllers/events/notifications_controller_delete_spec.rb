# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::NotificationsController, type: :controller do
  let(:user) { create(:user) }

  describe 'DELETE /events/notifications/:id' do
    subject(:delete_event) { delete :destroy, params: { id: Notification.first.id } }

    describe 'when user is authenticated' do
      before do
        sign_in(user)
        create(:notification, user:)
      end

      it 'delete event in the database' do
        expect { delete_event }.to change(Notification, :count).from(1).to(0)
      end

      it 'redirect to events_path' do
        delete_event
        expect(response).to redirect_to(events_path)
      end

      it 'sets a flash notice message' do
        delete_event
        expect(flash[:notice]).to match('Event successfully deleted')
      end
    end

    describe 'when user is not authenticated' do
      before { create(:notification) }

      it 'not delete event in the database' do
        expect { delete_event }.not_to change(Notification, :count).from(1)
      end

      it 'return status 302' do
        delete_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        delete_event
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
