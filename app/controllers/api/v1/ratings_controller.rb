# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApplicationController
      def create
        result = CreateRating.new.call(params: rating_params)
        if result.success?
          render json: result.value!, status: :ok
        else
          render json: { errors: result.failure }, status: :unprocessable_entity
        end
      end

      private

      def rating_params
        params.permit(:post_id, :star)
      end
    end
  end
end
