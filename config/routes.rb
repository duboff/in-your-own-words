Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }

  resources :users do
    collection { get :search }
    member { post :upload }
  end
end
