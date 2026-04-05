# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { %w[Personal Work Vacation].sample }
  end

  trait :personal do
    name { 'Personal' }
  end

  trait :work do
    name { 'Work' }
  end

  trait :vacation do
    name { 'Vacation' }
  end
end
