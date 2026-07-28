class ChapterSerializer
  ATTRIBUTES = [ :id, :title, :content, :position, :published_at, :created_at ].freeze

  def self.render(chapter)
    chapter.as_json(only: ATTRIBUTES)
  end

  def self.render_collection(chapters)
    chapters.map { |chapter| render(chapter) }
  end
end
