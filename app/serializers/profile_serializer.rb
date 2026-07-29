class ProfileSerializer
  ATTRIBUTES = [ :id, :name, :handle, :bio, :location, :website, :avatar_url, :cover_url, :created_at ].freeze

  def self.render(user)
    user.as_json(only: ATTRIBUTES).merge(
      stats: {
        stories: user.stories.size,
        followers: user.followers.size,
        following: user.followed_users.size
      },
      achievements: AchievementSerializer.render_collection(user.achievements)
    )
  end
end
