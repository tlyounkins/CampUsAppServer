Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'groups/new'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'groups/:id/join/:user_id' => 'groups#join'
  get    'groups/:id/members' => 'groups#members'
  post   'users/new' => 'users#create'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :groups
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]

end
