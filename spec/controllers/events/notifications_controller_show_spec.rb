# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:notification) { create(:notification, user: user) }

  describe 'GET /events/notification/:id' do
    subject(:show_event_notification) { get :show, params: { id: id } }

    let(:notification) { create(:notification, user: user) }

    describe 'when user is authenticated and meeting belongs to user' do
      let(:id) { notification.id }

      before do
        sign_in(user)
        show_event_notification
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template('show')
      end

      it 'assigns @notification' do
        expect(assigns(:notification)).to eq(notification)
      end
    end

    describe 'when user is authenticated and meeting does not exist' do
      let(:id) { -1 }

      before do
        sign_in(user)
        show_event_notification
      end

      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'does not assign @meeting' do
        expect(assigns(:meeting)).to be_nil
      end
    end

    describe 'when user is authenticated and tries to access another user\'s notification' do
      let(:other_notification) { create(:notification, user: other_user) }
      let(:id) { other_notification.id }

      before do
        sign_in(user)
        show_event_notification
      end

      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'does not assign @meeting' do
        expect(assigns(:notification)).to be_nil
      end
    end

    describe 'when user is not authenticated' do
      let(:id) { notification.id }

      before { show_event_notification }

      it 'returns status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
