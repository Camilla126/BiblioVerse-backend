class ReviewSerializer
  ATTRIBUTES = [ :id, :rating, :content, :created_at ].freeze

  def self.render(review)
    review.as_json(only: ATTRIBUTES).merge(
      user: UserSerializer.render(review.user),
      book: BookSerializer.render(review.book)
    )
  end

  def self.render_collection(reviews)
    reviews.map { |review| render(review) }
  end
end
