# frozen_string_literal: true

class CreatePostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :user_ip
  attribute :login do |object|
    object.user.login
  end
end
