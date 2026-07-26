require "rails_helper"

RSpec.describe "Api::V1::Authentication::Logout", type: :request do
  describe "DELETE /api/v1/authentication/logout" do
    it "retorna 204" do
      delete "/api/v1/authentication/logout"

      expect(response).to have_http_status(:no_content)
    end
  end
end
