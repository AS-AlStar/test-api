# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    post factory: :post
    star { rand(1..5) }
  end
end
