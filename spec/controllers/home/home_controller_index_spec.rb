# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    let(:user) { create(:user) }

    render_views
    context 'when user is authenticated' do
      before do
        sign_in(user)
        get :index
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end

      it 'render partial sign_in' do
        expect(response).to render_template(partial: 'home/partials/_authenticated')
      end

      it 'render partial user_dropdown' do
        expect(response).to render_template(partial: 'users/partials/_user_dropdown')
      end

      it 'assigns @user' do
        expect(assigns(:user)).to be_a(UserPresenter)
      end
    end

    context 'when user is not authenticated' do
      before { get :index }

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end

      it 'render partial sign_in' do
        expect(response).to render_template(partial: 'home/partials/_no_authenticated')
      end

      it 'render partial entry' do
        expect(response).to render_template(partial: 'users/partials/_entry')
      end
    end
  end
end
