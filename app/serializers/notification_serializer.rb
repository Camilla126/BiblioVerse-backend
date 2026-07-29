class NotificationSerializer
  ATTRIBUTES = [ :id, :kind, :read, :payload, :created_at ].freeze

  def self.render(notification)
    notification.as_json(only: ATTRIBUTES).merge(
      actor: notification.actor && UserSerializer.render(notification.actor)
    )
  end

  def self.render_collection(notifications)
    notifications.map { |notification| render(notification) }
  end
end
