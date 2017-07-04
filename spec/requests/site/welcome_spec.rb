require "rails_helper"

describe "Site::WelcomeController", :aggregate_failures do
  context "GET /index" do
    it "main page of App" do
      get "/"

      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end
end
