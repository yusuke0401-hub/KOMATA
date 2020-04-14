Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :users, only:[:index, :show] do 
    member do 
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]

end
