Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "main#home"

  get "/get/:id", to: "main#get"
  
  get "/sign-up", to: "registrations#new"
  
  post "/sign-up", to: "registrations#create"

  get "/sign-in", to: "sessions#new"

  post "/sign-in", to: "sessions#create"
  
  delete "/sign-out", to: "sessions#destroy"

  get '/get_prompt/:uid', to: 'promptsession#get_prompt'

  get '/create_prompt', to: 'promptsession#new'

  post '/new_prompt', to: 'promptsession#set_prompt'

  post '/update_prompt', to: 'promptsession#update_prompt'

  post '/good_feed', to:'goodfeedback#get_feedback'
  
  post '/bad_feed', to:'badfeedback#get_feedback'
end
