# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::MeetingsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:meeting) { create(:meeting, user: user) }

  describe 'GET /events/meetings/:id' do
    subject(:show_event_meeting) { get :show, params: { id: id } }

    describe 'when user is authenticated and meeting belongs to user' do
      let(:id) { meeting.id }

      before do
        sign_in(user)
        show_event_meeting
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end

      it 'assigns @meeting' do
        expect(assigns(:meeting)).to eq(meeting)
      end
    end

    describe 'when user is authenticated and meeting does not exist' do
      let(:id) { -1 }

      before do
        sign_in(user)
        show_event_meeting
      end

      it 'does not assign @meeting' do
        expect(assigns(:meeting)).to be_nil
      end
    end

    describe 'when user is authenticated and tries to access another user\'s meeting' do
      let(:other_meeting) { create(:meeting, user: other_user) }
      let(:id) { other_meeting.id }

      before do
        sign_in(user)
        show_event_meeting
      end

      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'when user is not authenticated' do
      let(:id) { meeting.id }

      before { show_event_meeting }

      it 'returns status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
