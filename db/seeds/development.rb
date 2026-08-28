# frozen_string_literal: true

default_categories = %w[Personal Work Vacation].map { |category| Category.find_or_create_by!(name: category) }

default_roles = %w[common admin].map { |role| Role.find_or_create_by!(name: role) }

User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.password = 'password'
  user.role = default_roles[1]
end

users = 5.times.map do |index|
  User.find_or_create_by!(email: "user_#{index}@example.com") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.password = 'password'
    user.role = default_roles[0]
  end
end

100.times do
  event_type = %w[Meeting Notification].sample
  event_date = Faker::Date.between(from: DateTime.now.tomorrow, to: 1.year.from_now)

  common_params = {
    name: Faker::Lorem.word,
    event_date: event_date,
    category: default_categories.sample,
    user: users.sample
  }

  case event_type
  when 'Meeting'
    Meeting.create!(common_params.merge(
                      start_time: event_date.strftime('%H:%M'),
                      end_time: (event_date + 1.hour).strftime('%H:%M')
                    ))
  when 'Notification'
    Notification.create!(common_params.merge(
                           notification_text: Faker::Lorem.sentence
                         ))
  end
end

users.each do |user|
  default_categories.each do |category|
    UserCategory.create(user:, category:)
  end
end
