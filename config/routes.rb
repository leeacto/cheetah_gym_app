CheetahGymApp::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  
  resources :results
  resources :daywods
  resources :users do
    resources :bios
  end
  resources :bios
  resources :sessions, :only => [:new, :create, :destroy]
  resources :wods do
    resources :daywods do
      resources :results
    end
  end

  match '/contact', :to => 'pages#contact'
  match '/help', :to => 'pages#help'
  match '/about', :to => 'pages#about'
  match '/schedule', :to => 'pages#schedule'
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/wodlist', :to => 'wods#index'
  match '/athletes', :to => 'users#index'
  match '/mywods', :to => 'users#wods'
  match '/newworkout', :to => 'pages#create_workout'
  root :to => 'pages#home'

end
