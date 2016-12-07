Rails.application.routes.draw do

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # App routes
  root to: 'pages#home'
  resources :listings do
    resources :bookings
    resources :furnitures
  end
end
