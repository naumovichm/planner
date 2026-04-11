# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up page', type: :feature do
  let(:user) { build(:user) }

  before { visit new_user_registration_path }

  describe 'when user is registered' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Register'
    end

    it { expect(page).to have_content('Welcome! You have signed up successfully.') }
  end

  describe 'when no first_name' do
    before do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Register'
    end

    it { expect(page).to have_content("First name can't be blank") }
  end

  describe 'when no email' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Register'
    end

    it { expect(page).to have_content("Email can't be blank") }
  end

  describe 'when no password' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      click_button 'Register'
    end

    it { expect(page).to have_content("Password can't be blank") }
  end

  describe 'when passwords are not the same' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: 'passwordd'
      click_button 'Register'
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end
end
