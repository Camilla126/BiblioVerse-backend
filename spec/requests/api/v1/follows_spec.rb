require "rails_helper"

RSpec.describe "Api::V1::Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/users/:id/follow" do
    it "retorna 401 quando não autenticado" do
      post "/api/v1/users/#{other_user.id}/follow"

      expect(response).to have_http_status(:unauthorized)
    end

    it "passa a seguir o usuário" do
      post "/api/v1/users/#{other_user.id}/follow", headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(user.followed_users).to include(other_user)
    end

    it "retorna 422 ao tentar seguir a si mesmo" do
      post "/api/v1/users/#{user.id}/follow", headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 422 ao seguir o mesmo usuário duas vezes" do
      create(:follow, follower: user, followed: other_user)

      post "/api/v1/users/#{other_user.id}/follow", headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 404 quando o usuário alvo não existe" do
      post "/api/v1/users/0/follow", headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/v1/users/:id/follow" do
    it "deixa de seguir o usuário" do
      create(:follow, follower: user, followed: other_user)

      delete "/api/v1/users/#{other_user.id}/follow", headers: auth_headers

      expect(response).to have_http_status(:no_content)
      expect(user.followed_users.reload).not_to include(other_user)
    end

    it "retorna 404 quando não segue o usuário" do
      delete "/api/v1/users/#{other_user.id}/follow", headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/users/:id/followers" do
    it "lista quem segue o usuário" do
      create(:follow, follower: other_user, followed: user)

      get "/api/v1/users/#{user.id}/followers", headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.map { |u| u["id"] }).to eq([ other_user.id ])
    end
  end

  describe "GET /api/v1/users/:id/following" do
    it "lista quem o usuário segue" do
      create(:follow, follower: user, followed: other_user)

      get "/api/v1/users/#{user.id}/following", headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.map { |u| u["id"] }).to eq([ other_user.id ])
    end
  end
end
