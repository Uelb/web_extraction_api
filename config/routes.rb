SsqlWebExtractionApi::Application.routes.draw do
  resources :centroids, only: :create, defaults: {format: 'json'}
  resources :websites, only: :show do 
    get ':label', to: 'websites#get_from_label'
  end
  resources :items, only: :show
  get 'jsons/*path', to: 'centroids#show'
  match '/*path' => 'application#cors_preflight_check', :via => :options
end
