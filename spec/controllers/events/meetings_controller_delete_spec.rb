# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::MeetingsController, type: :controller do
  let(:user) { create(:user) }
  let!(:meeting) { create(:meeting, user: user) }

  describe 'DELETE /events/meetings/:id' do
    subject(:delete_event) { delete :destroy, params: { id: id } }

    describe 'when user is authenticated' do
      let(:id) { meeting.id }

      before { sign_in(user) }

      it 'deletes the meeting' do
        expect { delete_event }.to change(Meeting, :count).by(-1)
      end

      it 'redirects to events_path' do
        delete_event
        expect(response).to redirect_to(events_path)
      end

      it 'sets a flash notice message' do
        delete_event
        expect(flash[:notice]).to match('Event successfully deleted')
      end
    end

    describe 'when user is authenticated but meeting does not exist' do
      let(:id) { -1 }

      before { sign_in(user) }

      it 'returns status 404' do
        delete_event
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'when user is authenticated and tries to delete another user\'s meeting' do
      let(:other_user) { create(:user) }
      let!(:other_meeting) { create(:meeting, user: other_user) }
      let(:id) { other_meeting.id }

      before { sign_in(user) }

      it 'returns status 404' do
        delete_event
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not delete the meeting' do
        expect { delete_event }.not_to change(Meeting, :count)
      end
    end

    describe 'when user is not authenticated' do
      let(:id) { meeting.id }

      before do
        sign_out(user)
        delete_event
      end

      it 'does not delete the meeting' do
        expect { delete_event }.not_to change(Meeting, :count)
      end

      it 'returns status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
