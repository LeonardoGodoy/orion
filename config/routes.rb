Rails.application.routes.draw do
  get  'home/index'
  root 'home#index'

  devise_for :users

  resources :disciplines
  resources :courses
  resources :institutions
  resources :groups
  resources :users

  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :users, only: :create

    resources :disciplines, except: [:new, :edit, :destroy]
    resources :courses, except: [:new, :edit, :destroy]
    resources :institutions, except: [:new, :edit, :destroy]
    resources :groups, except: [:new, :edit, :destroy]
    resources :subscriptions, only: [:create, :update, :destroy]
  end
end
