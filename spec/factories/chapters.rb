FactoryBot.define do
  factory :chapter do
    story
    sequence(:title) { |n| "Capítulo #{n}" }
    content { "Era uma vez..." }
    position { 0 }
    published_at { nil }
  end
end
