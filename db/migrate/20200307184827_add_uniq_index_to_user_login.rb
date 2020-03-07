# frozen_string_literal: true

class AddUniqIndexToUserLogin < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :login, unique: true
  end
end
