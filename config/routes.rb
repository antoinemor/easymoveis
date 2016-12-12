Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Root path
  root to: 'pages#home'

  # User bookings list
  get '/booking/user_bookings', to: 'bookings#user_bookings', as: 'user_bookings'
  get '/bookings', to: 'bookings#index', as: 'bookings'

  # User listings list
  get '/listings/user_listings', to: 'listings#user_listings', as: 'user_listings'
  get '/search', to: 'search#index', as: 'search'

  # Furniture by ambiance
  get '/ambiances/:ambiance_id', to: 'ambiances#index', as: 'ambiances'

  # App routes
  resources :listings do
      member do
        get '/approve', to: 'listings#approve_booking', as: 'approve'
        get '/reject', to: 'listings#reject_booking', as: 'reject'
        get '/rent', to: 'listings#rent_booking', as: 'rent'
        get '/finish', to: 'listings#finish_booking', as: 'finish'
      end

    resources :bookings, except: [:destroy]
    resources :furnitures
  end

  resources :bookings, only: [:destroy]

  # Messaging routes
  resources :conversations, only: [:index, :show, :destroy] do
    collection do
      delete :empty_trash
    end
    member do
        post :reply
        post :restore
        post :mark_as_read
      end
  end

  resources :messages, only: [:new, :create]

  # App pages routes
  get '/about',   to: 'pages#about',   as: 'about'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/team',    to: 'pages#team',    as: 'team'

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  # Addresses routes for facebook users
  resources :addresses, only: [:new, :create]

  # Attachinary
  mount Attachinary::Engine => "/attachinary"
end
