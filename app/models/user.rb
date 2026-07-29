class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :stories, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, inverse_of: :follower, dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, inverse_of: :followed, dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements

  has_many :notifications, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :handle, uniqueness: true, allow_nil: true
end
