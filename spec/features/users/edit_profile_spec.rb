# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit profle', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit edit_user_registration_path
  end

  describe 'change first_name' do
    before do
      fill_in 'First name', with: 'Therry'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'change last_name' do
    before do
      fill_in 'Last name', with: 'Last'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'change password' do
    before do
      fill_in 'Password', with: 'newpassword'
      fill_in 'Password confirmation', with: 'newpassword'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'when current_password is empty' do
    before { click_button 'Update' }

    it { expect(page).to have_content("Current password can't be blank") }
  end

  describe 'when password is not equal password_confirmation' do
    before do
      fill_in 'Password', with: 'newpassword'
      fill_in 'Password confirmation', with: 'Newpassword'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end
end
