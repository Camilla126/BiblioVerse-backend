require "rails_helper"

RSpec.describe Review, type: :model do
  it "é válida com user, book, rating e content" do
    expect(build(:review)).to be_valid
  end

  it "é inválida sem content" do
    expect(build(:review, content: nil)).not_to be_valid
  end

  it "é inválida com rating fora do intervalo 1..5" do
    expect(build(:review, rating: 0)).not_to be_valid
    expect(build(:review, rating: 6)).not_to be_valid
  end

  it "é inválida quando o usuário já avaliou o mesmo livro" do
    existing = create(:review)

    expect(build(:review, user: existing.user, book: existing.book)).not_to be_valid
  end
end
