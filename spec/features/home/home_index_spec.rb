# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  describe 'start page' do
    let(:user) { create(:user, events: [event_future, event_today]) }
    let(:category) { create(:category) }
    let(:event_today) { create(:event, event_date: DateTime.now + 5.minutes, category:) }
    let(:event_future) { create(:event, event_date: DateTime.now.tomorrow, category:) }

    before { visit root_path }

    it { expect(page).to have_xpath "//div[contains(@class, 'container')]" }
    it { expect(page).to have_button 'Language' }

    describe 'dropdown menu of language button' do
      before { click_button 'Language' }

      it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
    end

    describe 'switch language to ru' do
      before do
        click_button 'Language'
        click_link 'RU'
      end

      it { expect(page).to have_button 'Язык' }
    end

    describe 'when user is authenticated' do
      before do
        login_as(user)
        visit root_path
      end

      it { expect(page).to have_content(user.first_name) }
      it { expect(page).to have_content('You have events in future: 1') }
      it { expect(page).to have_content('You have events today: 1') }
    end

    describe 'when user is not authenticated' do
      before do
        visit root_path
      end

      it { expect(page).to have_content('Login') }
      it { expect(page).to have_xpath "//a[contains(text(), 'Login')]" }
      it { expect(page).to have_xpath "//a[contains(text(), 'Sign Up')]" }
    end
  end
end
