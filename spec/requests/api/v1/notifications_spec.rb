require "rails_helper"

RSpec.describe "Api::V1::Notifications", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/notifications" do
    it "retorna 401 quando não autenticado" do
      get "/api/v1/notifications"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna somente as notificações do usuário autenticado, mais recentes primeiro" do
      create(:notification, user: user, created_at: 2.days.ago)
      newest = create(:notification, user: user, created_at: 1.hour.ago)
      create(:notification)

      get "/api/v1/notifications", headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(2)
      expect(body.first["id"]).to eq(newest.id)
    end
  end

  describe "PATCH /api/v1/notifications/mark_all_read" do
    it "marca todas as notificações do usuário como lidas" do
      first = create(:notification, user: user, read: false)
      second = create(:notification, user: user, read: false)
      other_user_notification = create(:notification, read: false)

      patch "/api/v1/notifications/mark_all_read", headers: auth_headers

      expect(response).to have_http_status(:no_content)
      expect(first.reload.read).to be true
      expect(second.reload.read).to be true
      expect(other_user_notification.reload.read).to be false
    end

    it "retorna 401 quando não autenticado" do
      patch "/api/v1/notifications/mark_all_read"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
