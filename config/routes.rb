Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
