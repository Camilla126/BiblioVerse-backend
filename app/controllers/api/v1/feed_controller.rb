module Api
  module V1
    class FeedController < ApplicationController
      def index
        # Sistema de seguir (issue #21) ainda não existe: por ora o feed
        # lista todos os posts, não só os de usuários seguidos.
        posts = Post.includes(:user, :book, :likes, :comments).order(created_at: :desc)

        render json: PostSerializer.render_collection(posts)
      end
    end
  end
end
