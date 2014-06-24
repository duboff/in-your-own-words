Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  resources :users
  resources :users do
    member do
      get :show
      get :index
      get :edit
      put :update
      post :upload
    end
  end
end
