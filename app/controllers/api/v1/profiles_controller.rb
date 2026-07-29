module Api
  module V1
    class ProfilesController < ApplicationController
      def show
        user = User.find_by!(handle: params[:handle])

        render json: ProfileSerializer.render(user)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Perfil não encontrado" }, status: :not_found
      end
    end
  end
end
