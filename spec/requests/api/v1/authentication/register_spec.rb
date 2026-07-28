require "rails_helper"

RSpec.describe "Api::V1::Authentication::Register", type: :request do
  describe "POST /api/v1/authentication/register" do
    it "cria o usuário e retorna o token quando os dados são válidos" do
      post "/api/v1/authentication/register", params: {
        user: { name: "Novo Usuário", email: "novo@example.com", password: "senha123" }
      }

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["token"]).to be_present
      expect(body["user"]["email"]).to eq("novo@example.com")
      expect(body["user"]).not_to have_key("password_digest")
    end

    it "retorna 422 quando os dados são inválidos" do
      post "/api/v1/authentication/register", params: {
        user: { name: "", email: "", password: "senha123" }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
