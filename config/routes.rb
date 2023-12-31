Rails.application.routes.draw do
  resources :styles
  resources :memberships do
    member do
      put 'confirm'
    end
  end
  resources :beer_clubs
  resources :users do
    member do
      put 'lock'
      put 'unlock'
    end
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'

  resources :places, only: [:index, :show]
  post 'places', to:'places#search'

  root 'breweries#index'
end