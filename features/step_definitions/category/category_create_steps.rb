# frozen_string_literal: true

When('I go to the new category page') do
  visit new_category_path
end

When('I fill in name category') do
  category = build(:category)
  fill_in 'Name', with: category.name
end

Then('I should be redirected to categories page') do
  expect(current_path).to eq(categories_path)
end

Then('I should see a success message') do
  expect(page).to have_content('Category successfully created')
end
