Rails.application.routes.draw do
  root 'menus#home'
  resources :users, :only => [:new, :create]
  resources :test, :only => [:new, :create] do
    collection do
      get :ranking
      get :review
      post :remain
    end
  end
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
