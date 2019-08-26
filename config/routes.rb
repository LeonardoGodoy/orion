Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :users, only: :create

    resources :disciplines, except: [:new, :edit, :destroy]
    resources :courses, except: [:new, :edit, :destroy]
    resources :institutions, except: [:new, :edit, :destroy]
  end
end
