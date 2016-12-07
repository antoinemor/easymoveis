Rails.application.routes.draw do

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # App routes
  root to: 'pages#home'
  resources :listings do
    resources :bookings
      member do
        get '/cancel', to: 'bookings#cancel_booking', as: 'cancel'
        get '/approve', to: 'bookings#approve_booking', as: 'approve'
        get '/reject', to: 'bookings#reject_booking', as: 'reject'
      end
    resources :furnitures
  end
end
