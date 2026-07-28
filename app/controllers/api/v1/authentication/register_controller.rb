module Api
  module V1
    module Authentication
      class RegisterController < ApplicationController
        skip_before_action :authenticate_user!, only: [ :create ], raise: false

        def create
          user = User.new(user_params)
          if user.save
            token = ::Authentication::JwtService.encode(user_id: user.id)
            render json: { token: token, user: UserSerializer.render(user) }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private
        def user_params
          params.require(:user).permit(:name, :email, :password)
        end
      end
    end
  end
end
