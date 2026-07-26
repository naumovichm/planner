# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { Role.find_or_create_by(name: 'common') }

    trait :admin do
      role { Role.find_or_create_by(name: 'admin') }
    end
  end
end
