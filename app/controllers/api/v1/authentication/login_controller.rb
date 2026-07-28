module Api
  module V1
    module Authentication
      class LoginController < ApplicationController
        skip_before_action :authenticate_user!, only: [ :create ], raise: false

        def create
          user = User.find_by(email: params[:email])

          if user&.authenticate(params[:password])
            token = ::Authentication::JwtService.encode(user_id: user.id)
            render json: { token: token, user: UserSerializer.render(user) }
          else
            render json: { error: "Credenciais inválidas" }, status: :unauthorized
          end
        end
      end
    end
  end
end
