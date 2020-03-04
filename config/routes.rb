# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create]

      resources :ratings, only: [:create]

      resources :user_ips, only: [:index]
    end
  end
end
