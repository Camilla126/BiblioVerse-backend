class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
