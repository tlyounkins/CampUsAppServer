Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'groups/new'
  get 'events/new'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'groups/:id/join/:user_id' => 'groups#join'
  get    'groups/:id/members' => 'groups#members'
  get    'users/:username/findId' => 'users#findId'
  get    'microposts/:id/posts' => 'microposts#posts'
  get    'group_microposts/:id/posts' => 'group_microposts#posts'
  get    'groups/getAll' => 'groups#getAll'
  get    'users/getAll' => 'users#getAll'
  get    'events/getAll' => 'events#getAll'
  get    'users/findId/:username' => 'users#findId'
  get    'group_event/getGroup/:group_id' => 'group_events#getGroup'
  post   'group_event/:group_id' => 'group_events#create'
  post   'users/new' => 'users#create'
  post   'login'   => 'sessions#create'
  post   'microposts/:id' => 'microposts#create'
  post   'group_microposts/:id' => 'group_microposts#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :groups
  resources :events
  resources :private_messages
  resources :group_events
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts
  resources :relationships,       only: [:create, :destroy]

end
