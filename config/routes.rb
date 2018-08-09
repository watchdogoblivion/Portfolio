Rails.application.routes.draw do
  
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end

  get 'angular-items', to: 'portfolios#angular'
  get 'ruby-on-Rails-items', to: 'portfolios#ruby_on_Rails'
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'more-about-me', to: 'pages#more_about_me'
  get 'certifications', to: 'pages#certifications'

  resources :blogs do 
  	member do 
  		get :toggle_status
      get :toggle_featured
  	end
  end

  mount ActionCable.server => '/cable'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
