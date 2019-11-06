Rails.application.routes.draw do
  get  'home/index'
  root 'home#index'

  devise_for :users

  resources :disciplines
  resources :courses
  resources :institutions
  resources :groups

  resources :students
  resources :admins

  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :students, only: :create

    post 'passwords/recover', to: 'passwords#recover'
    post 'passwords/reset', to: 'passwords#reset'

    resources :disciplines, except: [:new, :edit, :destroy]
    resources :courses, except: [:new, :edit, :destroy]
    resources :institutions, except: [:new, :edit, :destroy]
    resources :groups, except: [:new, :edit, :destroy] do
      get :recomendations, on: :collection
    end
    resources :subscriptions, only: [:index, :create, :update, :destroy]
    resources :managers, only: [:create, :destroy]
    resources :bans, only: [:create, :destroy]
    resources :events, except: [:new]
    resources :performances, except: [:new]
    resources :posts, except: [:new] do
      resources :classifications, only: [:create, :destroy], controller: :post_classifications
    end
  end
end
