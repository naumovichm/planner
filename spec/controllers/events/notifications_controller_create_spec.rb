# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::NotificationsController, type: :controller do
  describe 'POST /events/new' do
    subject(:create_event) { post :create, params: params }

    let(:user) { create(:user) }
    let(:notification) { build(:notification) }
    let(:category) { create(:category) }
    let(:params) do
      {
        notification: {
          name: notification.name,
          event_date: DateTime.now.tomorrow,
          notification_text: notification.notification_text,
          category_id: category.id
        }
      }
    end

    describe 'when user is authenticated' do
      before { sign_in(user) }

      context 'when params are valid' do
        it 'save event in the database' do
          expect { create_event }.to change(Notification, :count).by(1)
        end

        it 'redirect to events_path' do
          create_event
          expect(response).to redirect_to(events_path)
        end

        it 'set a flash message' do
          create_event
          expect(flash[:notice]).to eq('Event successfully created')
        end
      end

      context 'when params are not valid' do
        subject(:create_invalid_notification) { post :create, params: invalid_params }

        let(:invalid_params) do
          {
            notification: {
              name: '',
              event_date: DateTime.now.tomorrow,
              notification_text: notification.notification_text,
              category_id: category.id
            }
          }
        end

        it 'does not save event in the database' do
          expect { create_invalid_notification }.not_to change(Notification, :count)
        end

        it 'set a error message' do
          create_invalid_notification
          expect(assigns(:notification).errors[:name]).to include("can't be blank")
        end
      end
    end

    describe 'when user is no authenticated' do
      it 'return status 302' do
        create_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        create_event
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not save event in the database' do
        expect { create_event }.not_to change(Notification, :count)
      end
    end
  end
end
