# frozen_string_literal: true

class AddColumnAverageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :average_rating, :float, null: false, default: 0
  end
end
