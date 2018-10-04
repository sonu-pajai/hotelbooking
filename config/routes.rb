Rails.application.routes.draw do
  devise_for :users
  resources :rooms
  resources :bookings

  root :to => 'bookings#home'
  get 'home' => "bookings#home"

  namespace :api do
    namespace :v1 do
      resources :bookings, only: [:create, :index]
    end
  end

  # namespace :api, defaults: {format: 'json'} do
  #   scope :v1 do
  #     mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  #   end
  # end
end