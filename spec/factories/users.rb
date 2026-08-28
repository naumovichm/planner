# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { create(:role, :common) }

    trait :admin do
      role { create(:role, :admin) }
    end
  end
end
