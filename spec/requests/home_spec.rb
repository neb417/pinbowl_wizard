require "rails_helper"

RSpec.describe "/", type: :request do
  let(:org) { create(:organization) }
  let(:admin) { create(:admin_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  describe "GET/index" do
    it "renders successful response" do
      sign_in_as(user)
      get root_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it "renders successful response" do
      sign_in_as(admin)
      get root_path
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "GET/dashboard" do
    it "renders unauthorized response" do
      sign_in_as(user)
      get dashboard_path
      expect(response).to redirect_to(root_path)
    end

    it "renders successful response" do
      sign_in_as(admin)
      get dashboard_path
      expect(response).to be_successful
      expect(response).to render_template(:dashboard)
    end
  end
end
