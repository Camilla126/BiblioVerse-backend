require "rails_helper"

RSpec.describe "Api::V1::Books", type: :request do
  describe "GET /api/v1/books" do
    it "retorna a lista de livros" do
      create_list(:book, 3)

      get "/api/v1/books"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it "filtra por busca no título ou autor" do
      create(:book, title: "Duna", author: "Frank Herbert")
      create(:book, title: "1984", author: "George Orwell")

      get "/api/v1/books", params: { q: "duna" }

      body = JSON.parse(response.body)
      expect(body.size).to eq(1)
      expect(body.first["title"]).to eq("Duna")
    end

    it "filtra por gênero" do
      create(:book, genre: "Terror")
      create(:book, genre: "Romance")

      get "/api/v1/books", params: { genre: "Terror" }

      body = JSON.parse(response.body)
      expect(body.size).to eq(1)
      expect(body.first["genre"]).to eq("Terror")
    end
  end

  describe "GET /api/v1/books/:id" do
    it "retorna o livro quando existe" do
      book = create(:book)

      get "/api/v1/books/#{book.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(book.id)
    end

    it "retorna 404 quando o livro não existe" do
      get "/api/v1/books/0"

      expect(response).to have_http_status(:not_found)
    end
  end
end
