# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign in page', type: :feature do
  let(:user) { create(:user) }

  before { visit new_user_session_path }

  describe 'when password and login are valid' do
    before do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'
    end

    it { expect(page).to have_content('Signed in successfully.') }
  end

  describe 'when password is invalid' do
    before do
      fill_in 'Email', with: user.email
      click_button 'Login'
    end

    it { expect(page).to have_content('Invalid email or password.') }
  end

  describe 'when email is invalid' do
    before do
      fill_in 'Password', with: user.password
      click_button 'Login'
    end

    it { expect(page).to have_content('Invalid email or password.') }
  end
end
