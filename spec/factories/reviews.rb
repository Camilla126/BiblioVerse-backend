FactoryBot.define do
  factory :review do
    user
    book
    rating { 5 }
    content { "Um livro excelente!" }
  end
end
