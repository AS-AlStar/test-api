# frozen_string_literal: true

class CreateRating
  include Dry::Transaction

  step :validate_params
  step :find_post
  map :create_rating
  map :average_rating
  map :serialize_rating

  private

  def validate_params(input)
    validator = RatingValidator.new(input[:params])

    if validator.valid?
      Success(attributes: validator.attributes)
    else
      Failure(validator.errors.full_messages)
    end
  end

  def find_post(input)
    post = Post.find_by(id: input.dig(:attributes, :post_id))
    if post
      Success(attributes: input[:attributes], post: post)
    else
      error = "Post not found by id: #{input.dig(:attributes, :post_id)}"
      Failure(errors: error)
    end
  end

  def create_rating(input)
    Rating.create!(input[:attributes])
    input
  end

  def average_rating(input)
    average = Rating.where(post_id: input[:post].id).average(:star).to_f.round(2)
    { post_id: input.dig(:attributes, :post_id), average: average }
  end

  def serialize_rating(input)
    CreateRatingSerializer.new(input).serializable_hash
  end
end
