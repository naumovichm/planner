# frozen_string_literal: true

Given('I am on the home page') do
  visit root_path
end

Given('I am logged in as a user') do
  @user = create(:user)
  click_link 'Login'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Login'
end

When('I click submit button') { click_button 'Create' }

Then('I should see a success message for {string}') do |option|
  messages = {
    'category' => 'Category successfully created',
    'event' => 'Event successfully created'
  }
  expect(page).to have_content(messages[option])
end
