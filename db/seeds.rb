# frozen_string_literal: true

POST_COUNT = 200_000
USER_COUNT = 100
USER_IP_COUNT = 50
CREATE_POST_URL = 'http://localhost:3000/api/v1/posts'
CREATE_RATING_URL = 'http://localhost:3000/api/v1/ratings'

user_ips = Array.new(USER_IP_COUNT) { Faker::Internet.unique.ip_v4_address }
logins = Array.new(USER_COUNT) { Faker::Internet.unique.username }

create_post_params = {
  title: Faker::Book.title,
  description: Faker::Lorem.paragraph,
  login: logins.sample,
  user_ip: user_ips.sample
}

create_rating_params = {
  post_id: rand(1..200_000),
  star: rand(1..5)
}

def threads(threads_count, &block)
  Array.new(threads_count) do
    Thread.new(&block)
  end.each(&:join)
end

threads(10) { 100.times { RestClient.post CREATE_RATING_URL, create_rating_params } }
threads(10) { 20_000.times { RestClient.post CREATE_POST_URL, create_post_params } }
