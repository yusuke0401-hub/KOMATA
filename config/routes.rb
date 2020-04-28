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
      
      get :liked_otasuke_messages
    end
  end
  
  resources :explanation, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :komata_messages, only: [:index, :show ,:new, :create, :destroy] do 
    resources :otasuke_messages, only: [:create, :destroy]
  end
  resources :likes, only: [:create, :destroy] 

end
