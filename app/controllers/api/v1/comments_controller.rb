module Api
  module V1
    class CommentsController < ApplicationController
      def create
        post = Post.find(params[:post_id])
        comment = post.comments.build(comment_params.merge(user: current_user))

        if comment.save
          notify_post_owner(comment)
          render json: CommentSerializer.render(comment), status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Post não encontrado" }, status: :not_found
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end

      def notify_post_owner(comment)
        return if comment.post.user_id == current_user.id

        NotificationService.notify(
          user: comment.post.user,
          kind: :comment,
          actor: current_user,
          payload: { post_id: comment.post_id, comment_id: comment.id }
        )
      end
    end
  end
end
