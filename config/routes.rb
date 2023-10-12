Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/spree'

  root to: 'home#index'

  resources :cart, only: :index, controller: 'cart'
end
