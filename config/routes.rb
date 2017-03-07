Rails.application.routes.draw do
  get 'home' => 'home#index'

  root 'home#index'

  get 'cards', to: 'cards#index'
end
