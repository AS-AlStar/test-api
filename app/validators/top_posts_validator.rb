# frozen_string_literal: true

class TopPostsValidator
  include ActiveModel::Model

  attr_accessor :limit

  validates :limit, presence: true

  def attributes
    { limit: limit }
  end
end
