# frozen_string_literal: true

class CreatePostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :user_ip, :user_id
end
