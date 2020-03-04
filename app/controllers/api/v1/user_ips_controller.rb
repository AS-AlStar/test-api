# frozen_string_literal: true

module Api
  module V1
    class UserIpsController < ApplicationController
      def users_ip_list
        list = Post.joins(:user)
                   .group(:user_ip)
                   .select('user_ip, array_agg(users.login) as logins')
                   .having('count(users.login) > 1')
        render json: UsersIpsListSerializer.new(list).serializable_hash, status: :ok
      end
    end
  end
end
