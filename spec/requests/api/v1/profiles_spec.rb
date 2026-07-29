require "rails_helper"

RSpec.describe "Api::V1::Profiles", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/profiles/:handle" do
    it "retorna 401 quando não autenticado" do
      target = create(:user, handle: "autora")

      get "/api/v1/profiles/autora"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna o perfil com estatísticas e conquistas" do
      target = create(:user, handle: "autora")
      create(:story, user: target)
      create(:follow, follower: user, followed: target)
      user_achievement = create(:user_achievement, user: target)

      get "/api/v1/profiles/autora", headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body["handle"]).to eq("autora")
      expect(body["stats"]).to eq({ "stories" => 1, "followers" => 1, "following" => 0 })
      expect(body["achievements"].first["id"]).to eq(user_achievement.achievement.id)
      expect(body).not_to have_key("email")
    end

    it "retorna 404 quando o handle não existe" do
      get "/api/v1/profiles/ninguem", headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
