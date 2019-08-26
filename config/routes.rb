Rails.application.routes.draw do
  get  'home/index'
  root 'home#index'

  resources :disciplines
  resources :courses
  resources :institutions
  devise_for :users

  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
