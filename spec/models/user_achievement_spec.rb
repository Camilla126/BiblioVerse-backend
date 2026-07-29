require "rails_helper"

RSpec.describe UserAchievement, type: :model do
  it "é válida com user, achievement e unlocked_at" do
    expect(build(:user_achievement)).to be_valid
  end

  it "é inválida sem unlocked_at" do
    expect(build(:user_achievement, unlocked_at: nil)).not_to be_valid
  end

  it "não permite a mesma conquista duas vezes para o mesmo usuário" do
    existing = create(:user_achievement)

    expect(build(:user_achievement, user: existing.user, achievement: existing.achievement)).not_to be_valid
  end
end
