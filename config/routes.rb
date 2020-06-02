Rails.application.routes.draw do
  resources :mocks
  root "mocks#index"
  
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

# This is just for the path for /:slug
# resources :mockers, path: '/'
# get ':id', to: 'mockers#show', as: 'show'


end
