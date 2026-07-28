module Api
  module V1
    class StoriesController < ApplicationController
      def index
        stories = current_user.stories.includes(:chapters)

        render json: StorySerializer.render_collection(stories)
      end

      def create
        story = current_user.stories.build(story_params)

        if story.save
          render json: StorySerializer.render(story), status: :created
        else
          render json: { errors: story.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def story_params
        params.require(:story).permit(:title, :cover_url)
      end
    end
  end
end
