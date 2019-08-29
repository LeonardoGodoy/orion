Rails.application.routes.draw do
  get  'home/index'
  root 'home#index'

  resources :disciplines
  resources :courses
  resources :institutions
  resources :groups
  resources :users

  devise_for :users

  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :users, only: :create

    resources :disciplines, except: [:new, :edit, :destroy]
    resources :courses, except: [:new, :edit, :destroy]
    resources :institutions, except: [:new, :edit, :destroy]
    resources :groups, except: [:new, :edit, :destroy]
  end
end
