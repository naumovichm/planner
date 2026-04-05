# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }

  describe 'PATCH /events/:id' do
    subject(:edit_event) { patch :update, params: { id: event.id, event: { name: 'NewName' } } }

    let(:event) { create(:event, user:) }

    describe 'when user is authenticated' do
      before do
        sign_in(user)
        edit_event
      end

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to events_path' do
        expect(response).to redirect_to(events_path)
      end

      it 'set a flash message' do
        expect(flash[:notice]).to eq('Event updated successfully')
      end

      it 'update event name' do
        expect(event.reload.name).to eq('NewName')
      end
    end

    describe 'when user is not authenticated' do
      before { edit_event }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not update event name' do
        expect(event.reload.name).not_to eq('NewName')
      end
    end
  end
end
