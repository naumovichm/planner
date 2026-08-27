# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    initialize_with { Role.find_or_create_by(name: name) }

    name { 'common' }

    trait :common do
      name { 'common' }
    end

    trait :admin do
      name { 'admin' }
    end
  end
end
