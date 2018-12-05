Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Root / Home Page
  # root 'home#index'
  root 'products#index'

  # User Login Routes
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users

  # User Profile Routes
  get '/profile' => 'users#profile'
  get '/profile/:id' => 'users#profile/:id'

  # User Cart Routes
  # get '/cart' => 'users#cart'
  # get '/cart/:id' => 'users#cart/:id'
  # these make no fking difference???

  resource :cart, only: [:show]

  # Order Routes
  resources :order_items, only: [:create, :update, :destroy]

  # Checkout Route
  get 'braintree/new' => 'braintree#new'
  post 'braintree/checkout' => 'braintree#checkout'

  # Products Routes
  resources :products, only: [:new, :show, :create, :update, :delete]

  # Google OAuth Callback Routes
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

end
