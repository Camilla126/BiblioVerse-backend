class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true

  enum :kind, { review: 0, progress_update: 1, chapter_published: 2 }

  validates :content, presence: true
end
