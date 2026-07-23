# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.word }
    event_date { Faker::Time.forward(days: 1, period: :day) }
    category { association :category }
    user { association :user }
    type { 'Event' }
  end

  trait :with_description do
    description { Faker::Lorem.sentence(word_count: 3) }
  end

  trait :with_reminder do
    reminder_on { event_date - 4.hours }
  end
end
