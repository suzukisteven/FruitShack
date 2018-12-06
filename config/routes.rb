Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Root: Product storefront page
  root 'products#index'

  # User Login Routes
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Google OAuth Callback Routes
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # Facebook callback Routes
  # get 'auth/facebook/callback' => 'sessions#create'
  # get 'auth/failure' => redirect('/')

  resources :users

  # User Profile Routes
  get '/profile' => 'users#profile'
  get '/profile/:id' => 'users#profile/:id'

  # User Cart Routes
  # get '/cart' => 'users#cart'
  # get '/cart/:id' => 'users#cart/:id'
  # these made no difference.

  resource :cart, only: [:show]

  # Order Routes
  resources :order_items, only: [:create, :update, :destroy]

  # Search bar post request Route
  post "/products/search" => "products#search", as: "search"

  # Braintree Checkout Route
  get '/checkout' => 'braintree#new', as: 'checkout'
  post 'braintree/checkout' => 'braintree#checkout'

  # Twilio SMS post request Route
  post '/twilio/sms'

  # Products Routes
  resources :products, only: [:new, :show, :create, :update, :delete]

end
