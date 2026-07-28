FactoryBot.define do
  factory :user_book do
    user
    book
    status { :quero_ler }
    current_page { 0 }
    total_pages { nil }
  end
end
