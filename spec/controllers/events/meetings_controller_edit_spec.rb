# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::MeetingsController, type: :controller do
  let(:user) { create(:user) }

  describe 'PATCH /events/meetings/:id' do
    subject(:edit_event) { patch :update, params: { id: meeting.id, meeting: { name: 'NewName' } } }

    let(:meeting) { create(:meeting, user:) }

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
        expect { meeting.reload }.to change(meeting, :name).to('NewName')
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
        expect(meeting.reload.name).not_to eq('NewName')
      end
    end
  end
end
