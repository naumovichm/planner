# frozen_string_literal: true

Then('I should see a success message about successful sign in') do
  expect(page).to have_content('Signed in successfully')
end

Then('I should see the navigation bar with {string} link') do |link|
  within('nav') do
    expect(page).to have_link(link)
  end
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end
