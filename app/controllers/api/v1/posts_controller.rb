module Api
  module V1
    class PostsController < ApplicationController
      rescue_from ArgumentError, with: :render_invalid_kind

      def create
        post = current_user.posts.build(post_params)

        if post.save
          render json: PostSerializer.render(post), status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:book_id, :kind, :content)
      end

      def render_invalid_kind
        render json: { errors: [ "Tipo de post inválido" ] }, status: :unprocessable_entity
      end
    end
  end
end
