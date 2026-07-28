require "rails_helper"

RSpec.describe "Api::V1::Posts", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/posts" do
    it "cria um post para o usuário autenticado" do
      post "/api/v1/posts",
        params: { post: { kind: "progress_update", content: "Terminei o capítulo 3!" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(user.posts.count).to eq(1)
    end

    it "aceita um book_id opcional" do
      book = create(:book)

      post "/api/v1/posts",
        params: { post: { kind: "review", content: "Ótimo livro!", book_id: book.id } },
        headers: auth_headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(body["book"]["id"]).to eq(book.id)
    end

    it "retorna 422 quando falta content" do
      post "/api/v1/posts",
        params: { post: { kind: "progress_update", content: "" } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 422 quando o kind é inválido" do
      post "/api/v1/posts",
        params: { post: { kind: "inexistente", content: "Algo" } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 401 quando não autenticado" do
      post "/api/v1/posts", params: { post: { kind: "progress_update", content: "Algo" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
