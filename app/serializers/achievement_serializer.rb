class AchievementSerializer
  ATTRIBUTES = [ :id, :name, :description, :icon ].freeze

  def self.render(achievement)
    achievement.as_json(only: ATTRIBUTES)
  end

  def self.render_collection(achievements)
    achievements.map { |achievement| render(achievement) }
  end
end
