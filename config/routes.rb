# Remova o ".config" desta linha
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
    resources :users, only: [:create, :show, :update]
    
    post 'auth/login', to: 'auth#login'
    get 'auth/user', to: 'auth#userAuth'
    delete 'auth/logout', to: 'auth#logout'
  end
end