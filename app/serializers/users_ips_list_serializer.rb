# frozen_string_literal: true

class UsersIpsListSerializer
  include FastJsonapi::ObjectSerializer

  attribute :user_ip
  attribute :logins, &:logins
end
