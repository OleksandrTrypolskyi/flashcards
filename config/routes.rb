Rails.application.routes.draw do
  get 'home' => 'home#index'

  root 'home#index'

  resources :cards

  get 'cards', to: 'cards#index'
  get 'card',  to: 'cards#show'

  patch 'card_verification',  to: 'card_verification#update'

  resources :users
  get '/registration', to: 'users#new'
  resources :user_sessions
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  post '/logout', to: 'user_sessions#destroy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :decks
  get 'current_deck', to: 'decks#set_current_deck'
end
