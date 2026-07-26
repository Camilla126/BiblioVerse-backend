require "rails_helper"

RSpec.describe Book, type: :model do
  it "é válido com título e autor" do
    book = build(:book)
    expect(book).to be_valid
  end

  it "é inválido sem título" do
    book = build(:book, title: nil)
    expect(book).not_to be_valid
  end

  it "é inválido sem autor" do
    book = build(:book, author: nil)
    expect(book).not_to be_valid
  end
end
