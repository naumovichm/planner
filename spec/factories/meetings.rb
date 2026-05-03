# frozen_string_literal: true

FactoryBot.define do
  factory :meeting, parent: :event, class: 'Meeting' do
    start_time { event_date&.strftime('%H:%M') }
    end_time { (Time.zone.parse(start_time) + 1.minute).strftime('%H:%M') }
  end

  trait :with_invalid_start_time do
    start_time { (event_date - 1.minute).strftime('%H:%M') }
  end

  trait :with_invalid_end_time do
    end_time { (Time.zone.parse(start_time) - 1.minute).strftime('%H:%M') }
  end
end
