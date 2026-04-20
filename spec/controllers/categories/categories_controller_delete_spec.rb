# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }

  describe 'DELETE /categories/:id' do
    subject(:delete_category) { delete :destroy, params: { id: category.id } }

    let!(:category) { create(:category) }

    describe 'when user is authenticated delete category' do
      before do
        user.categories.push(category)
        sign_in(user)
      end

      it 'delete category in the database' do
        expect { delete_category }.to change(Category, :count).from(1).to(0)
      end

      it 'sets a flash notice message' do
        delete_category
        expect(flash[:notice]).to match('Category successfully deleted')
      end

      it 'redirect to categories_path' do
        delete_category
        expect(response).to redirect_to(categories_path)
      end
    end

    describe 'when user in not authenticated' do
      before { delete_category }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not delete category in the database' do
        expect { delete_category }.not_to change(Category, :count).from(1)
      end
    end
  end
end
