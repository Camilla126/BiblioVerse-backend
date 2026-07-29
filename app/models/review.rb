class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, as: :likeable, dependent: :destroy

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :book_id, message: "já avaliou este livro" }
end
