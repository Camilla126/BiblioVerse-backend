module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        notifications = current_user.notifications.includes(:actor).recent_first

        render json: NotificationSerializer.render_collection(notifications)
      end

      def mark_all_read
        current_user.notifications.unread.update_all(read: true)

        head :no_content
      end
    end
  end
end
