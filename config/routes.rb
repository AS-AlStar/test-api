# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create]

      resources :ratings, only: [:create]

      resources :custom, only: [] do
        collection do
          get :users_ip_list, to: 'customs#users_ip_list'
        end
      end
    end
  end
end
