require "rails_helper"

RSpec.describe Like, type: :model do
  it "é válido curtindo um post" do
    expect(build(:like, likeable: create(:post))).to be_valid
  end

  it "é válido curtindo uma review" do
    expect(build(:like, likeable: create(:review))).to be_valid
  end

  it "é inválido curtindo um tipo não permitido" do
    like = build(:like, likeable: create(:book))

    expect(like).not_to be_valid
  end

  it "é inválido curtindo a mesma coisa duas vezes" do
    existing = create(:like)

    expect(build(:like, user: existing.user, likeable: existing.likeable)).not_to be_valid
  end
end
