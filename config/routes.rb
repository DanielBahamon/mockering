Rails.application.routes.draw do

  root "mocks#index"
  # root "pages#maintenance"
  # root "pages#prelaunch"
  
  # devise_scope :mocker do
  #  authenticated  do
  #    root to: 'mocks#index'
  #  end
  #  unauthenticated do
  #    root to: 'devise/sessions#new', as: 'unauthenticated_root'
  #  end
  # end

  resources :mockers do
    member do
      post '/verify_phone_number' => 'mockers#verify_phone_number'
      patch 'update_phone_number' => 'mockers#update_phone_number'
    end
  end

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
    get '/tagged', to: "mocks#tagged", as: :tagged, only: [:index, :show]
  end

  resources :mock_appeals

  resources :mock_reports

  resources :mocker_appeals

  resources :mocker_reports

  resources :conversation_reports

  resources :blocks

  resources :subscriptions
  
  resource :friendships, only: [:create, :destroy]


  resources :reviews do
    member do
      put 'like' => 'reviews#like'
      put 'dislike' => 'reviews#dislike'
      put 'vote' => 'reviews#upvote'
      put 'unvote' => 'reviews#downvote'
    end
  end

  resources :answers do
    member do
      put 'like' => 'answers#like'
      put 'dislike' => 'answers#dislike'
      put 'vote' => 'answers#upvote'
      put 'unvote' => 'answers#downvote'
    end
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :howmockeringworks do
    collection do
      get '/policy_safety_copyright', to: 'howmockeringworks#policy_safety_copyright'
      get '/detecting_infringements', to: 'howmockeringworks#detecting_infringements'
      get '/enforcing', to: 'howmockeringworks#enforcing'
      get '/fake_engagement', to: 'howmockeringworks#fake_engagement'
      get '/impersonation', to: 'howmockeringworks#impersonation'
      get '/links_content', to: 'howmockeringworks#links_content'
      get '/spam_delusive_practices', to: 'howmockeringworks#spam_delusive_practices'
      get '/child_safety', to: 'howmockeringworks#child_safety'
      get '/custom_thumbnails', to: 'howmockeringworks#custom_thumbnails'
      get '/nudity_sexual_content', to: 'howmockeringworks#nudity_sexual_content'
      get '/suicide_self_injury', to: 'howmockeringworks#suicide_self_injury'
      get '/harassment_cyberbullying', to: 'howmockeringworks#harassment_cyberbullying'
      get '/dangerous_content', to: 'howmockeringworks#dangerous_content'
      get '/hate_speech', to: 'howmockeringworks#hate_speech'
      get '/criminal_organizations', to: 'howmockeringworks#criminal_organizations'
      get '/violent_content', to: 'howmockeringworks#violent_content'
      get '/featuring_firearms', to: 'howmockeringworks#featuring_firearms'
      get '/sale_illegal_good', to: 'howmockeringworks#sale_illegal_good'
      get '/strikes', to: 'howmockeringworks#strikes'
      get '/appeal', to: 'howmockeringworks#appeal'
      get '/age_restricted', to: 'howmockeringworks#age_restricted'
      get '/data_processing_terms', to: 'howmockeringworks#data_processing_terms'

      get '/sensitive_policy', to: 'howmockeringworks#sensitive_policy'
      get '/delusive_policy', to: 'howmockeringworks#delusive_policy'
      get '/dangerous_policy', to: 'howmockeringworks#dangerous_policy'
      get '/regulated_policy', to: 'howmockeringworks#regulated_policy'
      get '/protecting_identity', to: 'howmockeringworks#protecting_identity'
      get '/video_privacy', to: 'howmockeringworks#video_privacy'
      get '/privacy_guidelines', to: 'howmockeringworks#privacy_guidelines'
      get '/reporting', to: 'howmockeringworks#reporting'
      get '/trademark', to: 'howmockeringworks#trademark'
      get '/forgery', to: 'howmockeringworks#forgery'
      get '/defamation', to: 'howmockeringworks#defamation'


      get '/safetypolicies', to: 'safetypolicies#index'
      get '/safetypolicies/parent', to: 'safetypolicies#parent'

      get '/copyrights', to: 'copyrights#index'
      get '/copyrights/form_notice', to: 'copyrights#form_notice'
      get '/copyrights/fair_use', to: 'copyrights#fair_use'
      get '/copyrights/making_claims', to: 'copyrights#making_claims'

      resources :trademarkcontacts, only: [:new, :create]

      resources :forgerycontacts, only: [:new, :create]

      resources :copyrightcontacts, only: [:new, :create]

    end
  end

  resources :suggestions, only: [:new, :create]
  
  get '/notification_settings' => 'settings#edit'

  post '/notification_settings' => 'settings#update'

  resources :conversations, only: [:index, :create] do 
    resources :messages, only: [:index, :create]
    # post 'messages', to: 'messages#create'
  end

  # resources :groups


  get 'subscriptions' => 'subscriptions#index'

  get 'suscripciones' => 'subscriptions#es'

  get 'terms' => 'pages#terms'

  get 'privacy' => 'pages#privacy'

  get 'copyright' => 'pages#copyright'

  get 'search' => 'pages#search'

  get 'contribute' => 'pages#contribute'


  # This is just for the path for /:slug
  # resources :mockers, path: '/'
  # get ':id', to: 'mockers#show', as: 'show'

  # This is for username validation
  get 'username_validator/:slug', to: 'mockers#username_validator'

  get 'mentions', to: 'mockers#mentions'

  get 'mockets', to: 'mocks#mockets'

  get 'plays', to: 'mocks#plays'

  get 'liked', to: 'mocks#liked'

  get 'all', to: 'mocks#index'

  get 'your_mocks', to: 'mocks#your_mocks'

  get "/404", :to => "errors#not_found"

  get "/422", :to => "errors#unacceptable"

  get "/500", :to => "errors#internal_error"

  get 'ads.txt', :to => "pages#ads.txt"


  # %w( 404 422 500 ).each do |code|
  #   get code, :to => "errors#show", :code => code
  # end

  
end
