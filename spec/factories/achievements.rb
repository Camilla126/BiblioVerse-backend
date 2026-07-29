FactoryBot.define do
  factory :achievement do
    sequence(:name) { |n| "Conquista #{n}" }
    description { "Uma conquista de teste." }
    icon { "🏆" }
  end
end
