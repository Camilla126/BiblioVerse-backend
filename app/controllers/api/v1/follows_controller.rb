module Api
  module V1
    class FollowsController < ApplicationController
      def create
        target_user = User.find(params[:id])
        follow = current_user.active_follows.build(followed: target_user)

        if follow.save
          render json: { following: true }, status: :created
        else
          render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Usuário não encontrado" }, status: :not_found
      end

      def destroy
        target_user = User.find(params[:id])
        follow = current_user.active_follows.find_by!(followed_id: target_user.id)
        follow.destroy

        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Usuário não encontrado ou não seguido" }, status: :not_found
      end

      def followers
        target_user = User.find(params[:id])

        render json: UserSerializer.render_collection(target_user.followers)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Usuário não encontrado" }, status: :not_found
      end

      def following
        target_user = User.find(params[:id])

        render json: UserSerializer.render_collection(target_user.followed_users)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Usuário não encontrado" }, status: :not_found
      end
    end
  end
end
