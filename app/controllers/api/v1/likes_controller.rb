module Api
  module V1
    class LikesController < ApplicationController
      def create
        like = current_user.likes.build(like_params)

        if like.save
          notify_owner(like)
          render json: LikeSerializer.render(like), status: :created
        else
          render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        like = current_user.likes.find(params[:id])
        like.destroy

        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Curtida não encontrada" }, status: :not_found
      end

      private

      def like_params
        params.require(:like).permit(:likeable_type, :likeable_id)
      end

      def notify_owner(like)
        owner = like.likeable.user
        return if owner == current_user

        NotificationService.notify(
          user: owner,
          kind: :like,
          actor: current_user,
          payload: { likeable_type: like.likeable_type, likeable_id: like.likeable_id }
        )
      end
    end
  end
end
