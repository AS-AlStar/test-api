# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :post, inverse_of: :ratings
end
