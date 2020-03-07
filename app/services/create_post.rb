# frozen_string_literal: true

class CreatePost
  include Dry::Transaction

  step :validate_params
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

  def create_post(input)
    ActiveRecord::Base.transaction do
      begin
        user = User.find_or_create_by(login: input.dig(:user_attributes, :login))
      rescue ActiveRecord::RecordNotUnique
        retry
      end
      attributes = input[:post_attributes].merge!(user_id: user.id)
      post = Post.create!(attributes)
      post
    end
  end

  def serialize_post(input)
    CreatePostSerializer.new(input).serializable_hash
  end
end
