FactoryBot.define do
  factory :notification do
    user
    actor { nil }
    kind { :system }
    read { false }
    payload { {} }
  end
end
