require "rails_helper"

RSpec.describe "Api::V1::UserBooks", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/user_books" do
    it "retorna 401 quando não autenticado" do
      get "/api/v1/user_books"

      expect(response).to have_http_status(:unauthorized)
    end

    it "retorna somente a estante do usuário autenticado" do
      create(:user_book, user: user)
      create(:user_book)

      get "/api/v1/user_books", headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "filtra por status" do
      create(:user_book, user: user, status: :lendo)
      create(:user_book, user: user, status: :lido)

      get "/api/v1/user_books", params: { status: "lendo" }, headers: auth_headers

      body = JSON.parse(response.body)
      expect(body.size).to eq(1)
      expect(body.first["status"]).to eq("lendo")
    end

    it "retorna 422 quando o status do filtro é inválido" do
      get "/api/v1/user_books", params: { status: "inexistente" }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /api/v1/user_books" do
    it "adiciona um livro à estante do usuário autenticado" do
      book = create(:book)

      post "/api/v1/user_books",
        params: { user_book: { book_id: book.id, status: "quero_ler" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(user.user_books.count).to eq(1)
    end

    it "retorna 422 quando o livro já está na estante" do
      book = create(:book)
      create(:user_book, user: user, book: book)

      post "/api/v1/user_books",
        params: { user_book: { book_id: book.id, status: "quero_ler" } },
        headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "retorna 401 quando não autenticado" do
      book = create(:book)

      post "/api/v1/user_books", params: { user_book: { book_id: book.id } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH /api/v1/user_books/:id" do
    it "atualiza o status e o progresso de leitura" do
      user_book = create(:user_book, user: user, status: :quero_ler)

      patch "/api/v1/user_books/#{user_book.id}",
        params: { user_book: { status: "lendo", current_page: 42 } },
        headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(user_book.reload.status).to eq("lendo")
      expect(user_book.current_page).to eq(42)
    end

    it "retorna 404 quando o registro não pertence ao usuário autenticado" do
      other_user_book = create(:user_book)

      patch "/api/v1/user_books/#{other_user_book.id}",
        params: { user_book: { status: "lendo" } },
        headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
