# frozen_string_literal: true

class UsersIpsListSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :user_ip
  attribute :logins, &:logins
end
