# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts, counter_cache: :posts_count
  has_many :ratings, inverse_of: :post, dependent: :destroy
end
