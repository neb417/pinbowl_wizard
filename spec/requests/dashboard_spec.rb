require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    it "works! (now write some real specs)" do
      get dashboard_path
      expect(response).to have_http_status(200)
    end
  end
end
