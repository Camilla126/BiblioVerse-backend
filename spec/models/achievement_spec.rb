require "rails_helper"

RSpec.describe Achievement, type: :model do
  it "é válida com name" do
    expect(build(:achievement)).to be_valid
  end

  it "é inválida sem name" do
    expect(build(:achievement, name: nil)).not_to be_valid
  end

  it "é inválida com name duplicado" do
    create(:achievement, name: "Autor Best-Seller")

    expect(build(:achievement, name: "Autor Best-Seller")).not_to be_valid
  end
end
