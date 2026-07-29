require "rails_helper"

RSpec.describe "Api::V1::Reviews", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/reviews" do
    it "retorna 401 quando não autenticado" do
      book = create(:book)

      post "/api/v1/reviews", params: { review: { book_id: book.id, rating: 5, content: "Ótimo!" } }

      expect(response).to have_http_status(:unauthorized)
    end

    it "cria uma avaliação para o usuário autenticado" do
      book = create(:book)

      post "/api/v1/reviews",
        params: { review: { book_id: book.id, rating: 4, content: "Muito bom" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(user.reviews.count).to eq(1)
    end

    it "retorna 422 quando o usuário já avaliou o livro" do
      book = create(:book)
      create(:review, user: user, book: book)

      post "/api/v1/reviews",
        params: { review: { book_id: book.id, rating: 3, content: "De novo" } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 422 quando o rating é inválido" do
      book = create(:book)

      post "/api/v1/reviews",
        params: { review: { book_id: book.id, rating: 9, content: "Nota errada" } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
