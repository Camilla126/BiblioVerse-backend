class CommentSerializer
  ATTRIBUTES = [ :id, :content, :created_at ].freeze

  def self.render(comment)
    comment.as_json(only: ATTRIBUTES).merge(user: UserSerializer.render(comment.user))
  end

  def self.render_collection(comments)
    comments.map { |comment| render(comment) }
  end
end
