Rails.application.routes.draw do
  get 'home' => 'home#index'

  root 'home#index'

  resources :cards

  get 'cards', to: 'cards#index'
  get 'card', to: 'cards#show'

end
