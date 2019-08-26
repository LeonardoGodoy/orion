Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
