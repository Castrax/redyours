Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  get '/users' => 'tickets#index', as: :user_root
  resources :tickets, only: [:index, :show, :update] do
    resources :comments, only: [:new, :create]
  end
end
