Rails.application.routes.draw do
  get 'home', to: 'dashboard/home#index'

  root 'dashboard/home#index'

  scope "(:locale)", locale: /en|ru/ do
    namespace :dashboard do
      resources :cards
      resources :users
      resources :decks
    end

    patch 'card_verification',  to: 'dashboard/card_verification#update'

    namespace :home do
      resources :user_sessions
    end

    get 'home/registration', to: 'dashboard/users#new'

    get 'home/login', to: 'home/user_sessions#new'
    post 'login', to: 'home/user_sessions#create'
    post 'logout', to: 'home/user_sessions#destroy'

    post "oauth/callback" => "home/oauths#callback"
    get "oauth/callback" => "home/oauths#callback"
    get "oauth/:provider" => "home/oauths#oauth", :as => :auth_at_provider


    post 'current_deck', to: 'dashboard/decks#set_current_deck'
    post 'current_language', to: 'dashboard/users#set_current_language'
  end
end
