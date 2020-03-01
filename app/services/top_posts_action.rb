# frozen_string_literal: true

class TopPostsAction
  include Dry::Transaction

  step :validate_params
  map :top_posts
  map :serialize_rating

  private

  def validate_params(input)
    validator = TopPostsValidator.new(input[:params])

    if validator.valid?
      Success(attributes: validator.attributes)
    else
      Failure(validator.errors.full_messages)
    end
  end

  def top_posts(input)
    Post.joins(:ratings)
        .select('posts.*, avg(ratings.star) as avg_rating')
        .group('posts.id').order('avg_rating desc')
        .limit(input.dig(:attributes, :limit))
  end

  def serialize_rating(input)
    TopPostsSerializer.new(input).serializable_hash
  end
end
