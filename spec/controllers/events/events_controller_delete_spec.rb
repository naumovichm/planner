# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }

  describe 'DELETE /events/:id' do
    subject(:delete_event) { delete :destroy, params: { id: Event.first.id } }

    describe 'when user is authenticated' do
      before do
        sign_in(user)
        create(:event, user:)
      end

      it 'delete event in the database' do
        expect { delete_event }.to change(Event, :count).from(1).to(0)
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
      before { create(:event) }

      it 'not delete event in the database' do
        expect { delete_event }.not_to change(Event, :count).from(1)
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
