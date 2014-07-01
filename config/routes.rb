Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }

  resources :users do
    collection do
      get :search
      post :upload
    end
    # member {  }
  end
  resources :after_signup do
    collection do
      post :upload
    end
  end
end
