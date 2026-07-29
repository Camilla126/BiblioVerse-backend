require "rails_helper"

RSpec.describe Comment, type: :model do
  it "é válido com user, post e content" do
    expect(build(:comment)).to be_valid
  end

  it "é inválido sem content" do
    expect(build(:comment, content: nil)).not_to be_valid
  end
end
