FactoryBot.define do
  factory :story do
    user
    sequence(:title) { |n| "Obra #{n}" }
    status { :draft }
    cover_url { "https://example.com/cover.jpg" }
  end
end
