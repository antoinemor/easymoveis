Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Root path
  root to: 'pages#home'

  # User bookings list
  get '/booking/user_bookings', to: 'bookings#user_bookings', as: 'user_bookings'

  # User listings list
  get '/listings/user_listings', to: 'listings#user_listings', as: 'user_listings'
  get '/bookings', to: 'bookings#index', as: 'bookings'


  # App routes
  resources :listings do
      member do
        get '/approve', to: 'listing#approve_booking', as: 'approve'
        get '/reject', to: 'listing#reject_booking', as: 'reject'
        get '/rent', to: 'listing#rent_booking', as: 'rent'
        get '/finish', to: 'listing#finish_booking', as: 'finish'
      end

    resources :bookings
      member do
        get '/cancel', to: 'bookings#cancel_booking', as: 'cancel'
      end
    resources :furnitures
  end

  # Devise routes
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Attachinary
  mount Attachinary::Engine => "/attachinary"
end
