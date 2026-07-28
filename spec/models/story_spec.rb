require "rails_helper"

RSpec.describe Story, type: :model do
  it "é válido com user e title" do
    expect(build(:story)).to be_valid
  end

  it "é inválido sem title" do
    expect(build(:story, title: nil)).not_to be_valid
  end

  it "é inválido sem user" do
    expect(build(:story, user: nil)).not_to be_valid
  end

  it "expõe os status draft e published" do
    expect(Story.statuses).to eq({ "draft" => 0, "published" => 1 })
  end

  it "ordena os capítulos por position" do
    story = create(:story)
    segundo = create(:chapter, story: story, position: 1)
    primeiro = create(:chapter, story: story, position: 0)

    expect(story.chapters).to eq([ primeiro, segundo ])
  end

  it "remove os capítulos ao ser destruída" do
    story = create(:story)
    create(:chapter, story: story)

    expect { story.destroy }.to change(Chapter, :count).by(-1)
  end
end
