# frozen_string_literal: true

module Api
  module V1
    class CustomController < ApplicationController
      def users_ip_list
        list = Post.joins(:user)
                   .group(:user_ip)
                   .having('count(users.login) > 1')
                   .select('user_ip, array_agg(users.login) as logins')
        render json: UsersIpsListSerializer.new(list).serializable_hash, status: :ok
      end
    end
  end
end
