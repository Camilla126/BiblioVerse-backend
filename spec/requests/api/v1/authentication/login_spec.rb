require "rails_helper"

RSpec.describe "Api::V1::Authentication::Login", type: :request do
  describe "POST /api/v1/authentication/login" do
    it "retorna o token e o usuário quando as credenciais são válidas" do
      user = create(:user, password: "senha123")

      post "/api/v1/authentication/login", params: { email: user.email, password: "senha123" }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["token"]).to be_present
      expect(body["user"]["id"]).to eq(user.id)
      expect(body["user"]).not_to have_key("password_digest")
    end

    it "retorna 401 quando as credenciais são inválidas" do
      post "/api/v1/authentication/login", params: { email: "inexistente@example.com", password: "errada" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
