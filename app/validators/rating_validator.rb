# frozen_string_literal: true

class RatingValidator
  include ActiveModel::Model

  attr_accessor :post_id, :star

  validates :post_id, presence: true
  validates(
    :star,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    }
  )

  def attributes
    { post_id: post_id, star: star }
  end
end
