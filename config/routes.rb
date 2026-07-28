Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rotas de Autenticação (Login, Registro, Logout)
      namespace :authentication do
        post "login", to: "login#create"
        post "register", to: "register#create"
        delete "logout", to: "logout#destroy"
      end

      # Rotas de Usuário (Perfil)
      namespace :users do
        # get 'profile', to: 'profile#show'
        # patch 'profile', to: 'profile#update'
        resource :profile, only: [ :show, :update ], controller: "profile"
      end

      # Rotas de Livros (Catálogo)
      resources :books, only: [ :index, :show ]

      # Rotas do Feed Social
      get "feed", to: "feed#index"
      resources :posts, only: [ :create ]

      # Rotas da Estante do Usuário
      resources :user_books, only: [ :index, :create, :update ]

      # Rotas do Estúdio de Escrita
      resources :stories, only: [ :index, :create ] do
        resources :chapters, only: [ :create ]
      end
      resources :chapters, only: [ :update ]
    end
  end
end
