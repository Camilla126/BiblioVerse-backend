module Api
  module V1
    module Users
      class ProfileController < ApplicationController
        def show
          render json: ProfileSerializer.render(current_user)
        end

        def update
          if current_user.update(user_params)
            render json: ProfileSerializer.render(current_user)
          else
            render json: current_user.errors, status: :unprocessable_entity
          end
        end

        private
        def user_params
          params.require(:user).permit(:name, :email, :handle, :bio, :location, :website, :avatar_url, :cover_url) # Sem senha aqui!
        end
      end
    end
  end
end
