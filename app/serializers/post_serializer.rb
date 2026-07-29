class PostSerializer
  ATTRIBUTES = [ :id, :kind, :content, :created_at ].freeze

  def self.render(post)
    post.as_json(only: ATTRIBUTES).merge(
      user: UserSerializer.render(post.user),
      book: post.book && BookSerializer.render(post.book),
      likes_count: post.likes.size,
      comments_count: post.comments.size
    )
  end

  def self.render_collection(posts)
    posts.map { |post| render(post) }
  end
end
