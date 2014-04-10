SsqlWebExtractionApi::Application.routes.draw do
  devise_for :users
  resources :centroids, only: :create, defaults: {format: 'json'}
  get 'websites/extraction', to: 'websites#extraction'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'documentation', to: 'pages#documentation'
  resources :websites, only: [:new, :index] do 
    resources :labels, only: [:show, :index] do 
      resources :items, only: :index
    end
  end
  resources :feedbacks, only: :create
  resources :items, only: :create
  match '/*path' => 'application#cors_preflight_check', :via => :options
  root 'pages#home'
end
