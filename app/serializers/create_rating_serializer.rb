# frozen_string_literal: true

class CreateRatingSerializer
  include FastJsonapi::ObjectSerializer

  set_id :id do |object|
    object[:post_id]
  end
  set_type :post

  attribute :average do |object|
    object[:average]
  end
end
