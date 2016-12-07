Rails.application.routes.draw do

  # Root path
  root to: 'pages#home'

  # App routes
  resources :listings do
    resources :bookings
    resources :furnitures
  end

  # Devise routes
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Attachinary
  mount Attachinary::Engine => "/attachinary"
end
