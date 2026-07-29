FactoryBot.define do
  factory :comment do
    user
    post
    content { "Muito bom!" }
  end
end
