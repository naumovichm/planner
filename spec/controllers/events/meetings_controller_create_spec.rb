# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::MeetingsController, type: :controller do
  describe 'POST /events/meetings/new' do
    subject(:create_event) { post :create, params: params }

    let(:user) { create(:user) }
    let(:meeting) { build(:meeting) }
    let(:category) { create(:category) }
    let(:params) do
      {
        meeting: {
          name: meeting.name,
          event_date: meeting.event_date,
          category_id: category.id,
          start_time: meeting.start_time,
          end_time: meeting.end_time
        }
      }
    end

    describe 'when user is authenticated' do
      before { sign_in(user) }

      context 'when params are valid' do
        it 'save event in the database' do
          expect { create_event }.to change(Meeting, :count).by(1)
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

      context 'when params are invalid' do
        subject(:create_invalid_meeting) { post :create, params: invalid_params }

        let(:invalid_params) do
          {
            meeting: {
              name: '',
              event_date: meeting.event_date,
              category_id: category.id,
              start_time: meeting.start_time,
              end_time: meeting.end_time
            }
          }
        end

        it 'does not save event in the database' do
          expect { create_invalid_meeting }.not_to change(Meeting, :count)
        end

        it 'set a error message' do
          create_invalid_meeting
          expect(assigns(:meeting).errors[:name]).to include("can't be blank")
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
        expect { create_event }.not_to change(Meeting, :count)
      end
    end
  end
end
