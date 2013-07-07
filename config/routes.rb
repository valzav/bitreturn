Monetizer::Application.routes.draw do

  root to: 'welcome#index'

  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/login' => 'user_sessions#new', :as => :login
  match '/dashboard' => 'users#dashboard', :as => :dashboard
  match '/get_widget' => 'users#get_widget', :as => :get_widget
  get '/withdraw' => 'users#withdraw', :as => :withdraw
  put '/withdraw' => 'users#update_withdraw_settings'
  match '/generate_address' => 'welcome#generate_address'
  match '/widget_data' => 'welcome#widget_data'

  resource :user_session
  resources :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :visitor_actions
    end
  end

  match ':controller(/:action(/:id))(.:format)'
end
