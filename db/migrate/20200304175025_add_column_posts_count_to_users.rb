# frozen_string_literal: true

class AddColumnPostsCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :posts_count, :integer, null: false, default: 0
    add_index :users, :posts_count
  end
end
