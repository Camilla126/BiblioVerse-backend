require "rails_helper"

RSpec.describe Post, type: :model do
  it "é válido com user, kind e content" do
    expect(build(:post)).to be_valid
  end

  it "é válido sem book (book é opcional)" do
    expect(build(:post, book: nil)).to be_valid
  end

  it "é inválido sem content" do
    expect(build(:post, content: nil)).not_to be_valid
  end

  it "é inválido sem user" do
    expect(build(:post, user: nil)).not_to be_valid
  end

  it "expõe os kinds review, progress_update e chapter_published" do
    expect(Post.kinds).to eq({ "review" => 0, "progress_update" => 1, "chapter_published" => 2 })
  end
end
