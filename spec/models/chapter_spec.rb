require "rails_helper"

RSpec.describe Chapter, type: :model do
  it "é válido com story, title, content e position" do
    expect(build(:chapter)).to be_valid
  end

  it "é inválido sem title" do
    expect(build(:chapter, title: nil)).not_to be_valid
  end

  it "é inválido sem content" do
    expect(build(:chapter, content: nil)).not_to be_valid
  end

  it "é inválido com position negativa" do
    expect(build(:chapter, position: -1)).not_to be_valid
  end

  it "não está publicado quando published_at é nil" do
    expect(build(:chapter, published_at: nil)).not_to be_published
  end

  it "está publicado quando published_at está presente" do
    expect(build(:chapter, published_at: Time.current)).to be_published
  end
end
