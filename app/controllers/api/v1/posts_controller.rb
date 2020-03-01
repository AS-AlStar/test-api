# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def create
        result = CreatePost.new.call(params: post_params)
        if result.success?
          render json: result.value!, status: :ok
        else
          render json: { errors: result.failure }, status: :unprocessable_entity
        end
      end

      def index
        result = TopPostsAction.new.call(params: params.permit(:limit)) if params[:limit]
        # result = IndexPostService - logic for return default action :index
        if result.success?
          render json: result.value!, status: :ok
        else
          render json: { errors: result.failure }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.permit(:title, :description, :user_ip, :login)
      end
    end
  end
end
