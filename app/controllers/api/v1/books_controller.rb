module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all
        books = books.where("title ILIKE :q OR author ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
        books = books.where(genre: params[:genre]) if params[:genre].present?

        render json: BookSerializer.render_collection(books)
      end

      def show
        book = Book.find(params[:id])
        render json: BookSerializer.render(book)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Livro não encontrado" }, status: :not_found
      end
    end
  end
end
