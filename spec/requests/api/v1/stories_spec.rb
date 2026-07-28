require "rails_helper"

RSpec.describe "Api::V1::Stories", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/stories" do
    it "retorna 401 quando não autenticado" do
      get "/api/v1/stories"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna somente as obras do usuário autenticado" do
      create(:story, user: user)
      create(:story)

      get "/api/v1/stories", headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "POST /api/v1/stories" do
    it "cria uma obra para o usuário autenticado" do
      post "/api/v1/stories", params: { story: { title: "Minha Obra" } }, headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(user.stories.count).to eq(1)
    end

    it "retorna 422 quando falta title" do
      post "/api/v1/stories", params: { story: { title: "" } }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
