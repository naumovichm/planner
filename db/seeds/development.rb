# frozen_string_literal: true

default_categories = %w[Personal Work Vacation].map { |category| Category.find_or_create_by!(name: category) }

users = 5.times.map do |index|
  User.find_or_create_by!(email: "user_#{index}@example.com") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.password = 'password'
  end
end

100.times do
  Event.create!(
    name: Faker::Lorem.word,
    event_date: Faker::Date.between(from: DateTime.now.tomorrow, to: 1.year.from_now),
    category: default_categories.sample,
    user: users.sample
  )
end

users.each do |user|
  default_categories.each do |category|
    UserCategory.create(user:, category:)
  end
end
