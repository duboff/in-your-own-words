Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }

  resources :users do
    resources :skills
    collection do
      get :search
      post :upload
    end
  end
  resources :after_signup do
    collection do
      post :upload
    end
  end
  root :to => "home#index"
end
