class NotificationService
  def self.notify(user:, kind:, actor: nil, payload: {})
    Notification.create!(user: user, kind: kind, actor: actor, payload: payload)
  end
end
