require "rails_helper"

RSpec.describe "Api::V1::Users::Profile", type: :request do
  describe "GET /api/v1/users/profile" do
    it "retorna 401 quando não há header Authorization" do
      get "/api/v1/users/profile"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna 401 quando o token é inválido" do
      get "/api/v1/users/profile", headers: { "Authorization" => "Bearer token-invalido" }

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna o usuário autenticado quando o token é válido" do
      user = create(:user)
      token = Authentication::JwtService.encode(user_id: user.id)

      get "/api/v1/users/profile", headers: { "Authorization" => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(user.id)
      expect(body).not_to have_key("password_digest")
    end
  end

  describe "PATCH /api/v1/users/profile" do
    let(:user) { create(:user) }
    let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

    it "atualiza os campos de perfil do próprio usuário" do
      patch "/api/v1/users/profile",
        params: { user: { handle: "leitora123", bio: "Adoro ficção científica", location: "Recife, BR" } },
        headers: auth_headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["handle"]).to eq("leitora123")
      expect(body["bio"]).to eq("Adoro ficção científica")
    end

    it "retorna 422 quando o handle já está em uso" do
      create(:user, handle: "jaexiste")

      patch "/api/v1/users/profile", params: { user: { handle: "jaexiste" } }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 401 quando não autenticado" do
      patch "/api/v1/users/profile", params: { user: { bio: "Tentativa" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
