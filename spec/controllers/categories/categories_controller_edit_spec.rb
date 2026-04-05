# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }

  describe 'PATCH /category/:id' do
    subject(:edit_category) { patch :update, params: { id: category.id, category: { name: 'NewName' } } }

    let(:category) { create(:category) }

    describe 'when user is authenticated' do
      before do
        create(:user_category, user:, category:)
        sign_in(user)
        edit_category
      end

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to events_path' do
        expect(response).to redirect_to(categories_path)
      end

      it 'set a flash message' do
        expect(flash[:notice]).to eq('Category updated successfully')
      end

      it 'update category name' do
        expect(category.reload.name).to eq('NewName')
      end
    end

    describe 'when user is not authenticated' do
      before { edit_category }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not update category name' do
        expect(category.reload.name).not_to eq('NewName')
      end
    end
  end
end
