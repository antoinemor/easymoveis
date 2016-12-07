Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Root path
  root to: 'pages#home'

  # User listings list
  get '/listings/user_listings', to: 'listings#user_listings', as: 'user_listings'

  # App routes
  resources :listings do
    resources :bookings
      member do
        get '/cancel', to: 'bookings#cancel_booking', as: 'cancel'
        get '/approve', to: 'bookings#approve_booking', as: 'approve'
        get '/reject', to: 'bookings#reject_booking', as: 'reject'
      end
    resources :furnitures
  end

  # Devise routes
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Attachinary
  mount Attachinary::Engine => "/attachinary"
end
