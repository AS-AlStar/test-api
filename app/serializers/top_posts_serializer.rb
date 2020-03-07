# frozen_string_literal: true

class TopPostsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :average_rating
end
