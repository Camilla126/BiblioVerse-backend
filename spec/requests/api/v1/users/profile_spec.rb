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
end
