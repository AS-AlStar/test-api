# frozen_string_literal: true

class TopPostsAction
  include Dry::Transaction

  map :top_posts
  map :serialize_rating

  private

  def top_posts(input)
    Post.order(average_rating: :desc)
        .limit(input.dig(:params, :limit) || 5)
  end

  def serialize_rating(input)
    TopPostsSerializer.new(input).serializable_hash
  end
end
