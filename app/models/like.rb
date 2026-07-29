class Like < ApplicationRecord
  LIKEABLE_TYPES = %w[Post Review].freeze

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :likeable_type, inclusion: { in: LIKEABLE_TYPES }
  validates :user_id, uniqueness: { scope: [ :likeable_type, :likeable_id ], message: "já curtiu isso" }
end
