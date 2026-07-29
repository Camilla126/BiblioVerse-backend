class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  enum :kind, { review: 0, progress_update: 1, chapter_published: 2 }

  validates :content, presence: true
end
