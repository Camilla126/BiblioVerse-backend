class UserSerializer
  ATTRIBUTES = [ :id, :name, :email, :created_at ].freeze

  def self.render(user)
    user.as_json(only: ATTRIBUTES)
  end

  def self.render_collection(users)
    users.map { |user| render(user) }
  end
end
