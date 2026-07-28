module Api
  module V1
    class UserBooksController < ApplicationController
      rescue_from ArgumentError, with: :render_invalid_status

      def index
        user_books = current_user.user_books.includes(:book)

        if params[:status].present?
          return render_invalid_status unless UserBook.statuses.key?(params[:status])

          user_books = user_books.where(status: params[:status])
        end

        render json: UserBookSerializer.render_collection(user_books)
      end

      def create
        user_book = current_user.user_books.build(user_book_params)

        if user_book.save
          render json: UserBookSerializer.render(user_book), status: :created
        else
          render json: { errors: user_book.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        user_book = current_user.user_books.find(params[:id])

        if user_book.update(user_book_params)
          render json: UserBookSerializer.render(user_book)
        else
          render json: { errors: user_book.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Livro não encontrado na estante" }, status: :not_found
      end

      private

      def user_book_params
        params.require(:user_book).permit(:book_id, :status, :current_page, :total_pages)
      end

      def render_invalid_status
        render json: { errors: [ "Status inválido" ] }, status: :unprocessable_entity
      end
    end
  end
end
