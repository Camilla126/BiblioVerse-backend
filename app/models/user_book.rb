class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :status, { quero_ler: 0, lendo: 1, lido: 2 }

  validates :user_id, uniqueness: { scope: :book_id, message: "já está na estante" }
  validates :current_page, numericality: { greater_than_or_equal_to: 0 }
  validates :total_pages, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
