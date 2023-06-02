# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    
  end

  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.org" }
    password { 'password' }
  end
end
