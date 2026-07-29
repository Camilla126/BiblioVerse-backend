require "rails_helper"

RSpec.describe Notification, type: :model do
  it "é válida com user e kind" do
    expect(build(:notification)).to be_valid
  end

  it "é válida sem actor (actor é opcional)" do
    expect(build(:notification, actor: nil)).to be_valid
  end

  it "expõe os kinds like, comment, follow, achievement e system" do
    expect(Notification.kinds).to eq(
      { "like" => 0, "comment" => 1, "follow" => 2, "achievement" => 3, "system" => 4 }
    )
  end

  describe ".unread" do
    it "retorna somente as notificações não lidas" do
      unread = create(:notification, read: false)
      create(:notification, read: true)

      expect(Notification.unread).to eq([ unread ])
    end
  end

  describe ".recent_first" do
    it "ordena as notificações mais recentes primeiro" do
      older = create(:notification, created_at: 2.days.ago)
      newer = create(:notification, created_at: 1.hour.ago)

      expect(Notification.recent_first).to eq([ newer, older ])
    end
  end
end
