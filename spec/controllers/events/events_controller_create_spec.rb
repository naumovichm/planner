# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'POST /events/new' do
    subject(:create_event) do
      post :create,
           params: { event: { name: category.name, event_date: DateTime.now.tomorrow, category_id: category.id } }
    end

    let(:user) { create(:user) }
    let(:category) { create(:category) }

    describe 'when user is authenticated' do
      before { sign_in(user) }

      it 'save event in the database' do
        expect { create_event }.to change(Event, :count).from(0).to(1)
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
        expect { create_event }.not_to change(Event, :count).from(0)
      end
    end
  end
end
