# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'POST /categories/new' do
    subject(:create_category) { post :create, params: { category: { name: category.name } } }

    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:category) { build(:category) }

    describe 'when user is authenticated' do
      before { sign_in(user) }

      it 'returns status 404' do
        create_category
        expect(response).to have_http_status(:forbidden)
      end

      it 'not save category in the database' do
        expect { create_category }.not_to change(Category, :count)
      end
    end

    describe 'when admin is authenticated' do
      before { sign_in(admin) }

      it 'redirect to categories_path' do
        create_category
        expect(response).to redirect_to(categories_path)
      end

      it 'set a flash message' do
        create_category
        expect(flash[:notice]).to eq('Category successfully created')
      end

      it 'when save category in the database' do
        expect { create_category }.to change(Category, :count).by(1)
      end
    end

    describe 'when user is no authenticated' do
      before { create_category }

      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not save category in the database' do
        expect { create_category }.not_to change(Category, :count)
      end
    end
  end
end
