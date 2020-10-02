Rails.application.routes.draw do
  root 'menus#home'
  get  'ajax_test/top',    to: 'ajax_test#top',    as: 'ajax_test_top'
  post 'ajax_test/update', to: 'ajax_test#update', as: 'ajax_test_update'
  resources :users, :only => [:new, :create]
  resources :test, :only => [:new, :create]
  resources :questions do
    resources :question_similar, :only => [:new, :create, :destroy]
    collection do
      get :search
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
