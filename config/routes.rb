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

      # Rotas do Sistema de Seguir
      resources :users, only: [] do
        member do
          post "follow", to: "follows#create"
          delete "follow", to: "follows#destroy"
          get "followers", to: "follows#followers"
          get "following", to: "follows#following"
        end
      end

      # Rotas de Perfil Público (por handle)
      resources :profiles, only: [ :show ], param: :handle

      # Rotas de Notificações
      get "notifications", to: "notifications#index"
      patch "notifications/mark_all_read", to: "notifications#mark_all_read"
    end
  end
end
