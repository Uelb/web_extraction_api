SsqlWebExtractionApi::Application.routes.draw do
  scope "(:locale)", locale: /en|fr|ja/ do
    devise_for :users
    resources :centroids, only: :create, defaults: {format: 'json'}
    get 'websites/extraction', to: 'websites#extraction'
    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'
    get 'documentation', to: 'pages#documentation'
    resources :websites, only: [:new, :index, :destroy, :show] do 
      resources :labels do 
        get 'container_items', to: 'items#container_index'
        resources :items, only: :index
      end
    end
    resources :feedbacks, only: :create
    resources :items, only: :create
    match '/*path' => 'application#cors_preflight_check', :via => :options
  end
  root 'pages#home'
  get '/:locale' => 'pages#home', constraints: {locale: /en|fr|ja/}
  get '/auth/:provider/callback', to: 'sessions#create'  
end
