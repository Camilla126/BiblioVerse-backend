require "rails_helper"

RSpec.describe NotificationService do
  describe ".notify" do
    it "cria uma notificação para o usuário" do
      user = create(:user)
      actor = create(:user)

      notification = described_class.notify(user: user, kind: :follow, actor: actor, payload: { foo: "bar" })

      expect(notification).to be_persisted
      expect(notification.user).to eq(user)
      expect(notification.actor).to eq(actor)
      expect(notification.kind).to eq("follow")
      expect(notification.payload).to eq({ "foo" => "bar" })
    end

    it "cria uma notificação sem actor" do
      user = create(:user)

      notification = described_class.notify(user: user, kind: :system)

      expect(notification.actor).to be_nil
    end
  end
end
