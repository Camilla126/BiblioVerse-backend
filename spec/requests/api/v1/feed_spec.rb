require "rails_helper"

RSpec.describe "Api::V1::Feed", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/feed" do
    it "retorna 401 quando não autenticado" do
      get "/api/v1/feed"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna os posts mais recentes primeiro" do
      older = create(:post, created_at: 2.days.ago)
      newer = create(:post, created_at: 1.hour.ago)

      get "/api/v1/feed", headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.map { |post| post["id"] }).to eq([ newer.id, older.id ])
    end

    it "retorna vazio quando não há posts" do
      get "/api/v1/feed", headers: auth_headers

      expect(JSON.parse(response.body)).to eq([])
    end

    it "inclui a contagem de curtidas e comentários de cada post" do
      post_record = create(:post)
      create_list(:like, 2, likeable: post_record)
      create(:comment, post: post_record)

      get "/api/v1/feed", headers: auth_headers

      body = JSON.parse(response.body).first
      expect(body["likes_count"]).to eq(2)
      expect(body["comments_count"]).to eq(1)
    end
  end
end
