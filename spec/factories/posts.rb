# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    user_ip { Faker::Internet.unique.ip_v4_address }
    trait :factory_user do
      user factory: :user
    end
  end
end
