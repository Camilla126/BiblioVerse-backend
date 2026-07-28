FactoryBot.define do
  factory :post do
    user
    book { nil }
    kind { :progress_update }
    content { "Avancei mais um capítulo hoje!" }
  end
end
