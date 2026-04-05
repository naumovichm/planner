# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET /category/:id' do
    subject(:show_category) { get :show, params: { id: category.id } }

    let(:category) { create(:category) }

    describe 'when user is authenticated' do
      before do
        user.categories << category
        sign_in(user)
        show_category
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template('show')
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end
    end

    describe 'when user in not authenticated' do
      before { show_category }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
