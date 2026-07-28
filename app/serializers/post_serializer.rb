class PostSerializer
  ATTRIBUTES = [ :id, :kind, :content, :created_at ].freeze

  def self.render(post)
    post.as_json(only: ATTRIBUTES).merge(
      user: UserSerializer.render(post.user),
      book: post.book && BookSerializer.render(post.book)
    )
  end

  def self.render_collection(posts)
    posts.map { |post| render(post) }
  end
end
