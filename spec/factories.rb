# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
  end

  factory :message do
    body { "MyText" }
  end

  factory :comment do
    
  end

  factory :like do
  end

  factory :post do
  end

  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.org" }
    password { 'password' }
  end
end
