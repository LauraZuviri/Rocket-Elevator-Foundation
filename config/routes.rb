Rails.application.routes.draw do

  
  resources :interventions
  post 'sms' => 'twilio#sms'
  get 'sms' => 'twilio#sms'
  # resources :comments
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/residential' =>'home#residential'
  get '/commercial' =>'home#commercial'
  get '/quote' =>'quote#quote'
  get '/maps/location' =>'maps#location'
  get '/index-RocketElevators.html' =>'home#index'
  get '/index-rocketElevators-residential.html' => 'home#residential'
  get '/index-rocketElevators-commercial.html' => 'home#commercial'
  get '/index-Quote.html' => 'quote#quote'
  post '/new_quote' =>'quote#new_quote'
  post '/new_lead' =>'lead#new_lead'
  get '/chart' =>'charts#chart'
  get '/dropbox' =>'lead#index'
  post '/new_intervention' => 'interventions#new_intervention'
  get '/buildings_for_customer' => 'interventions#buildings_for_customer'
  get '/batteries_for_building' => 'interventions#batteries_for_building'
  get '/columns_for_battery' => 'interventions#columns_for_battery' 
  get '/elevators_for_column' => 'interventions#elevators_for_column'  
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'

end





