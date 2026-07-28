FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "usuario#{n}@example.com" }
    name { "Usuário Teste" }
    password { "senha123" }
  end
end
