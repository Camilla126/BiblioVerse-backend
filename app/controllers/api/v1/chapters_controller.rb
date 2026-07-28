module Api
  module V1
    class ChaptersController < ApplicationController
      def create
        story = current_user.stories.find(params[:story_id])
        chapter = story.chapters.build(chapter_params.merge(position: story.chapters.count))

        if chapter.save
          render json: ChapterSerializer.render(chapter), status: :created
        else
          render json: { errors: chapter.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Obra não encontrada" }, status: :not_found
      end

      def update
        chapter = Chapter.where(story: current_user.stories).find(params[:id])

        if chapter.update(chapter_params)
          render json: ChapterSerializer.render(chapter)
        else
          render json: { errors: chapter.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Capítulo não encontrado" }, status: :not_found
      end

      private

      def chapter_params
        params.require(:chapter).permit(:title, :content, :position, :published_at)
      end
    end
  end
end
