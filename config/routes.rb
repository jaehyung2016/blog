Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  resources :users, except: [:show, :edit]
  get '/account' => 'users#edit'
  resources :sessions, only: :create
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
