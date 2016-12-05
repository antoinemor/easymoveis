Rails.application.routes.draw do
  get 'listings/index'

  get 'listings/new'

  get 'listings/edit'

  get 'listings/show'

  get 'listings/update'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
