class UserBookSerializer
  ATTRIBUTES = [ :id, :status, :current_page, :total_pages, :created_at ].freeze

  def self.render(user_book)
    user_book.as_json(only: ATTRIBUTES).merge(book: BookSerializer.render(user_book.book))
  end

  def self.render_collection(user_books)
    user_books.map { |user_book| render(user_book) }
  end
end
