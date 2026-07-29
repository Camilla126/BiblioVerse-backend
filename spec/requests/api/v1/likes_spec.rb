require "rails_helper"

RSpec.describe "Api::V1::Likes", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/likes" do
    it "retorna 401 quando não autenticado" do
      post_record = create(:post)

      post "/api/v1/likes", params: { like: { likeable_type: "Post", likeable_id: post_record.id } }

      expect(response).to have_http_status(:unauthorized)
    end

    it "curte um post" do
      post_record = create(:post)

      post "/api/v1/likes",
        params: { like: { likeable_type: "Post", likeable_id: post_record.id } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(post_record.likes.count).to eq(1)
    end

    it "curte uma review" do
      review = create(:review)

      post "/api/v1/likes",
        params: { like: { likeable_type: "Review", likeable_id: review.id } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(review.likes.count).to eq(1)
    end

    it "notifica o dono do conteúdo curtido" do
      owner = create(:user)
      post_record = create(:post, user: owner)

      expect {
        post "/api/v1/likes",
          params: { like: { likeable_type: "Post", likeable_id: post_record.id } },
          headers: auth_headers
      }.to change(owner.notifications, :count).by(1)
    end

    it "não notifica quando o autor curte o próprio post" do
      post_record = create(:post, user: user)

      expect {
        post "/api/v1/likes",
          params: { like: { likeable_type: "Post", likeable_id: post_record.id } },
          headers: auth_headers
      }.not_to change(user.notifications, :count)
    end

    it "retorna 422 para um likeable_type não permitido" do
      book = create(:book)

      post "/api/v1/likes",
        params: { like: { likeable_type: "Book", likeable_id: book.id } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 422 ao curtir a mesma coisa duas vezes" do
      post_record = create(:post)
      create(:like, user: user, likeable: post_record)

      post "/api/v1/likes",
        params: { like: { likeable_type: "Post", likeable_id: post_record.id } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /api/v1/likes/:id" do
    it "descurte" do
      like = create(:like, user: user)

      delete "/api/v1/likes/#{like.id}", headers: auth_headers

      expect(response).to have_http_status(:no_content)
      expect(Like.exists?(like.id)).to be false
    end

    it "retorna 404 quando a curtida não pertence ao usuário autenticado" do
      other_like = create(:like)

      delete "/api/v1/likes/#{other_like.id}", headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
