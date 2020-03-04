# frozen_string_literal: true

class UserIpsListSerializer
  include FastJsonapi::ObjectSerializer

  attribute :user_ip
  attribute :logins do |object|
    object.logins.uniq
  end
end
