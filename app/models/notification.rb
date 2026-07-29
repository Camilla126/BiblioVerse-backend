class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User", optional: true

  enum :kind, { like: 0, comment: 1, follow: 2, achievement: 3, system: 4 }

  scope :unread, -> { where(read: false) }
  scope :recent_first, -> { order(created_at: :desc) }
end
