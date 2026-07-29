require "rails_helper"

RSpec.describe "Api::V1::Comments", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/posts/:post_id/comments" do
    it "retorna 401 quando não autenticado" do
      post_record = create(:post)

      post "/api/v1/posts/#{post_record.id}/comments", params: { comment: { content: "Legal!" } }

      expect(response).to have_http_status(:unauthorized)
    end

    it "cria um comentário no post" do
      post_record = create(:post)

      post "/api/v1/posts/#{post_record.id}/comments",
        params: { comment: { content: "Muito bom esse post" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(post_record.comments.count).to eq(1)
    end

    it "notifica o dono do post" do
      owner = create(:user)
      post_record = create(:post, user: owner)

      expect {
        post "/api/v1/posts/#{post_record.id}/comments",
          params: { comment: { content: "Muito bom esse post" } },
          headers: auth_headers
      }.to change(owner.notifications, :count).by(1)
    end

    it "não notifica quando o autor comenta no próprio post" do
      post_record = create(:post, user: user)

      expect {
        post "/api/v1/posts/#{post_record.id}/comments",
          params: { comment: { content: "Comentando em mim mesmo" } },
          headers: auth_headers
      }.not_to change(user.notifications, :count)
    end

    it "retorna 404 quando o post não existe" do
      post "/api/v1/posts/0/comments", params: { comment: { content: "Legal!" } }, headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end

    it "retorna 422 quando falta content" do
      post_record = create(:post)

      post "/api/v1/posts/#{post_record.id}/comments", params: { comment: { content: "" } }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
