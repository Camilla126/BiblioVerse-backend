Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # auth
      post   "login",  to: "auth#login"
      delete "logout", to: "auth#logout"
      get    "me",     to: "auth#me"

      # users
      resources :users, only: [:show, :update, :create]

    end
  end
end

