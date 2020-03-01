# frozen_string_literal: true

class PostValidator
  include ActiveModel::Model

  attr_accessor :title, :description, :login, :user_ip

  validates :title, presence: true
  validates :description, presence: true
  validates :login, presence: true
  validates :user_ip, presence: true

  def post_attributes
    { title: title, description: description, user_ip: user_ip }
  end

  def user_attributes
    { login: login }
  end
end
