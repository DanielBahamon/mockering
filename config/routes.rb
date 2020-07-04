Rails.application.routes.draw do
  
  # root "mocks#index"
  devise_scope :mocker do
    authenticated  do
      root to: 'mocks#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
 
  resources :mockers
  devise_for :mockers,
        path: '',
        path_names: {
          sign_in: 'login', 
          sign_out: 'logout', 
          edit: 'profile', 
          sign_up: 'registration'
        }, 
        controllers: {
          omniauth_callbacks: 'omniauth_callbacks',
          registrations: 'registrations'
        }
  resources :mocks do
  	member do
  		put 'like' => 'mocks#like'
  		put 'dislike' => 'mocks#dislike'
  		put 'vote' => 'mocks#upvote'
  		put 'unvote' => 'mocks#downvote'
  	end
  end

  resources :reviews

  get 'terms' => 'pages#terms'
  get 'policy' => 'pages#policy'


  resource :friendships, only: [:create, :destroy]

  # This is just for the path for /:slug
  # resources :mockers, path: '/'
  # get ':id', to: 'mockers#show', as: 'show'

  # This is for username validation
  get 'username_validator/:slug', to: 'mockers#username_validator'



  

end
