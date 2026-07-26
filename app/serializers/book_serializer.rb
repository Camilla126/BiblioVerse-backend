class BookSerializer
  ATTRIBUTES = [ :id, :title, :author, :genre, :cover_url, :synopsis, :published_at, :created_at ].freeze

  def self.render(book)
    book.as_json(only: ATTRIBUTES)
  end

  def self.render_collection(books)
    books.map { |book| render(book) }
  end
end
