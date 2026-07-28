require "rails_helper"

RSpec.describe UserBook, type: :model do
  it "é válido com user, book e status padrão" do
    expect(build(:user_book)).to be_valid
  end

  it "expõe os status quero_ler, lendo e lido" do
    expect(UserBook.statuses).to eq({ "quero_ler" => 0, "lendo" => 1, "lido" => 2 })
  end

  it "não permite o mesmo livro duas vezes na estante do mesmo usuário" do
    existing = create(:user_book)
    duplicate = build(:user_book, user: existing.user, book: existing.book)

    expect(duplicate).not_to be_valid
  end

  it "não permite current_page negativo" do
    expect(build(:user_book, current_page: -1)).not_to be_valid
  end

  it "não permite total_pages negativo" do
    expect(build(:user_book, total_pages: -1)).not_to be_valid
  end

  it "é inválido sem user" do
    expect(build(:user_book, user: nil)).not_to be_valid
  end

  it "é inválido sem book" do
    expect(build(:user_book, book: nil)).not_to be_valid
  end
end
