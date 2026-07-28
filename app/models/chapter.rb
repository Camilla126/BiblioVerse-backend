class Chapter < ApplicationRecord
  belongs_to :story

  validates :title, presence: true
  validates :content, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  def published?
    published_at.present?
  end
end
