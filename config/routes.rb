Rails.application.routes.draw do
  
  # root "mocks#index"
  devise_scope :mocker do
    root to: "devise/sessions#new"
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

  


# This is just for the path for /:slug
# resources :mockers, path: '/'
# get ':id', to: 'mockers#show', as: 'show'


end
