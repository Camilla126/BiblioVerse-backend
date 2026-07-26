Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      # Rotas de Autenticação (Login, Registro, Logout)
      namespace :authentication do
        post 'login', to: 'login#create'
        post 'register', to: 'register#create'
        delete 'logout', to: 'logout#destroy'
      end

      # Rotas de Usuário (Perfil)
      namespace :users do
        # get 'profile', to: 'profile#show'
        # patch 'profile', to: 'profile#update'
        resource :profile, only: [:show, :update], controller: 'profile'
      end

      # Rotas de Livros (Catálogo)
      resources :books, only: [:index, :show]

    end
  end
end