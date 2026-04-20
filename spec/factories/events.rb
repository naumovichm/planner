# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.word }
    event_date { Faker::Date.between(from: DateTime.now.tomorrow, to: 1.year.from_now) }
    category { association :category }
    user { association :user }
  end

  trait :with_description do
    description { Faker::Lorem.sentence(word_count: 3) }
  end

  trait :with_reminder do
    reminder_on { event_date - 4.hours }
  end
end
