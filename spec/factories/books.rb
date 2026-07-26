FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Livro #{n}" }
    author { "Autor Teste" }
    genre { "Fantasia" }
    cover_url { "https://example.com/cover.jpg" }
    synopsis { "Uma sinopse de teste." }
    published_at { 1.year.ago }
  end
end
