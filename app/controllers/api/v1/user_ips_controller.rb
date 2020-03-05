# frozen_string_literal: true

module Api
  module V1
    class UserIpsController < ApplicationController
      def index
        list = Post.joins(:user)
                   .group(:user_ip)
                   .where('users.posts_count > 1')
                   .having('count(users.login) > 1')
                   .select('user_ip, array_agg(users.login) as logins')
        list = list.paginate(page: params[:page], per_page: 30) unless shown_all?
        render json: UserIpsListSerializer.new(list).serializable_hash, status: :ok
      end

      private

      def shown_all?
        params[:force] == 'true'
      end
    end
  end
end
