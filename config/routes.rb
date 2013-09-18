Monetizer::Application.routes.draw do

  root to: 'welcome#index'

  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/login' => 'user_sessions#new', :as => :login
  match '/' => 'welcome#index', :as => :dashboard

  resource :user_session
  resources :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :visitor_actions
      resources :market_envs
      resources :miners
      resources :assets
      resources :analysis_results
    end
  end

  match ':controller(/:action(/:id))(.:format)'
end
