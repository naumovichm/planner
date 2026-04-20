# frozen_string_literal: true

Given('I have a category') do
  @category = create(:category)
  create(:user_category, user: @user, category: @category)
end

When('I go to the new event page') do
  visit new_event_path
end

When('I fill in name') do
  @event = build(:event)
  fill_in 'Name', with: @event.name
end

When('I select category') do
  select @category.name, from: 'Category select'
end

When('I fill in date') do
  fill_in 'Event date', with: @event.event_date
end

Then('I should be redirected to events page') do
  expect(current_path).to eq(events_path)
end

Then('I should see a success message') do
  expect(page).to have_content('Event successfully created')
end
