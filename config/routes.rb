Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Root / Home Page
  root 'home#index'

  # User Login Routes
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  #User Profile Routes
  get '/profile' => 'users#profile'
  get '/profile/:id' => 'users#profile/:id'

  resources :users

  # Products Routes
  resources :products, only: [:new, :show, :create, :update, :delete]

  # Google OAuth Callback Routes
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

end
