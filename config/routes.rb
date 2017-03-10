Rails.application.routes.draw do
  get 'home' => 'home#index'

  root 'home#index'

  resources :cards

  get 'cards', to: 'cards#index'
  get 'card',  to: 'cards#show'


  # resources :card_verification
  post 'card_verification',  to: 'card_verification#update'
end
