Rails.application.routes.draw do
  root 'posts#index'
  get 'page/:page/', action: :index, controller: :posts, as: :page

  resources :posts do
#   resources :comments, shallow: true #TODO
    get 'search', on: :collection #TODO  
    get 'preview', on: :new #TODO
#   get 'page/:page', action: :index, on: :collection
  end

  resources :users, except: [:show, :edit]
  get 'account', to: 'users#edit'  

  resources :sessions, only: :create
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
