class LikeSerializer
  ATTRIBUTES = [ :id, :likeable_type, :likeable_id, :created_at ].freeze

  def self.render(like)
    like.as_json(only: ATTRIBUTES)
  end
end
