class StorySerializer
  ATTRIBUTES = [ :id, :title, :status, :cover_url, :created_at ].freeze

  def self.render(story)
    story.as_json(only: ATTRIBUTES).merge(chapters: ChapterSerializer.render_collection(story.chapters))
  end

  def self.render_collection(stories)
    stories.map { |story| render(story) }
  end
end
