require "rails_helper"

RSpec.describe "Api::V1::Chapters", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { "Authorization" => "Bearer #{Authentication::JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/stories/:story_id/chapters" do
    it "adiciona um capítulo à obra do usuário autenticado" do
      story = create(:story, user: user)

      post "/api/v1/stories/#{story.id}/chapters",
        params: { chapter: { title: "Capítulo 1", content: "Conteúdo" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(story.chapters.count).to eq(1)
    end

    it "posiciona o novo capítulo após o último existente" do
      story = create(:story, user: user)
      create(:chapter, story: story, position: 0)

      post "/api/v1/stories/#{story.id}/chapters",
        params: { chapter: { title: "Capítulo 2", content: "Conteúdo" } },
        headers: auth_headers

      body = JSON.parse(response.body)
      expect(body["position"]).to eq(1)
    end

    it "retorna 404 quando a obra não pertence ao usuário autenticado" do
      other_story = create(:story)

      post "/api/v1/stories/#{other_story.id}/chapters",
        params: { chapter: { title: "Capítulo 1", content: "Conteúdo" } },
        headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end

    it "retorna 401 quando não autenticado" do
      story = create(:story, user: user)

      post "/api/v1/stories/#{story.id}/chapters", params: { chapter: { title: "Capítulo 1", content: "Conteúdo" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH /api/v1/chapters/:id" do
    it "edita o conteúdo do capítulo" do
      chapter = create(:chapter, story: create(:story, user: user))

      patch "/api/v1/chapters/#{chapter.id}", params: { chapter: { title: "Novo título" } }, headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(chapter.reload.title).to eq("Novo título")
    end

    it "publica o capítulo ao enviar published_at" do
      chapter = create(:chapter, story: create(:story, user: user), published_at: nil)

      patch "/api/v1/chapters/#{chapter.id}", params: { chapter: { published_at: Time.current } }, headers: auth_headers

      expect(chapter.reload).to be_published
    end

    it "retorna 404 quando o capítulo não pertence a uma obra do usuário autenticado" do
      other_chapter = create(:chapter)

      patch "/api/v1/chapters/#{other_chapter.id}", params: { chapter: { title: "Invasão" } }, headers: auth_headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
