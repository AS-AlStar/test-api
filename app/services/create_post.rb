# frozen_string_literal: true

class CreatePost
  include Dry::Transaction

  step :validate_params
  map :find_or_create_user
  map :create_post
  map :serialize_post

  private

  def validate_params(input)
    validator = PostValidator.new(input[:params])

    if validator.valid?
      Success(user_attributes: validator.user_attributes, post_attributes: validator.post_attributes)
    else
      Failure(validator.errors.full_messages)
    end
  end

  def find_or_create_user(input)
    user = User.find_or_create_by(login: input.dig(:user_attributes, :login))
    input.merge(user: user)
  end

  def create_post(input)
    post = Post.new(input[:post_attributes])
    post.user = input[:user]
    post.save!
    post
  end

  def serialize_post(input)
    CreatePostSerializer.new(input).serializable_hash
  end
end
