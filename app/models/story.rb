class Story < ApplicationRecord
  belongs_to :user
  has_many :chapters, -> { order(:position) }, dependent: :destroy

  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true
end
