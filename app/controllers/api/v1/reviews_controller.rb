module Api
  module V1
    class ReviewsController < ApplicationController
      def create
        review = current_user.reviews.build(review_params)

        if review.save
          render json: ReviewSerializer.render(review), status: :created
        else
          render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def review_params
        params.require(:review).permit(:book_id, :rating, :content)
      end
    end
  end
end
