require "rails_helper"

RSpec.describe Follow, type: :model do
  it "é válido com follower e followed diferentes" do
    expect(build(:follow)).to be_valid
  end

  it "é inválido quando follower e followed são o mesmo usuário" do
    user = create(:user)

    expect(build(:follow, follower: user, followed: user)).not_to be_valid
  end

  it "é inválido quando o follower já segue o followed" do
    existing = create(:follow)

    expect(build(:follow, follower: existing.follower, followed: existing.followed)).not_to be_valid
  end
end
