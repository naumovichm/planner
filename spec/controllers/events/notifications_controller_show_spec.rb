# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::NotificationsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET /events/:id' do
    subject(:show_event_notification) { get :show, params: { id: notification.id } }

    let(:notification) { create(:notification, user: user) }

    describe 'when user is authenticated' do
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

    describe 'when user in not authenticated' do
      before { show_event_notification }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
