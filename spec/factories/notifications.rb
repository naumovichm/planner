# frozen_string_literal: true

FactoryBot.define do
  factory :notification, parent: :event, class: 'Notification' do
    notification_text { Faker::Lorem.sentence(word_count: 3) }
  end
end
