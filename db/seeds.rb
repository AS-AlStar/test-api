# frozen_string_literal: true

POST_COUNT = 200_000
USER_COUNT = 100_000
USER_IP_COUNT = 1000
CREATE_POST_URL = 'http://localhost:3000/api/v1/posts'
CREATE_RATING_URL = 'http://localhost:3000/api/v1/ratings'

USER_IPS = Array.new(USER_IP_COUNT) { Faker::Internet.unique.ip_v4_address }
LOGINS = Array.new(USER_COUNT) { Faker::Internet.unique.username }

def create_post_params
  {
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    login: LOGINS.sample,
    user_ip: USER_IPS.sample
  }
end

def create_rating_params
  {
    post_id: rand(1..200_000),
    star: rand(1..5)
  }
end

def threads(threads_count, &block)
  Array.new(threads_count) do
    Thread.new(&block)
  end.each(&:join)
end

threads(10) { 20_000.times { RestClient.post CREATE_POST_URL, create_post_params } }
threads(10) { 100.times { RestClient.post CREATE_RATING_URL, create_rating_params } }
