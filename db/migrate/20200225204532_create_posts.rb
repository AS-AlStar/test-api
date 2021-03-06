# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :user_ip, null: false, index: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
