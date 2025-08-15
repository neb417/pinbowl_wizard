require "rails_helper"

RSpec.describe "/dashboard", type: :request do
  let(:org) { create(:organization) }
  let(:owner) { create(:owner_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  describe "GET/index" do
    context "when user is not authorized" do
      it "redirects to root path" do

        allow(DashboardPolicy).to receive(:new).and_return(double(index?: false))
        sign_in_as(user)
        get dashboard_path
        expect(response).to redirect_to(root_path)
        expect(response.body).not_to include(org.name)
      end
    end

    it "redirects to root path if not valid" do
      sign_in_as(user)
      get dashboard_path
      expect(response).to redirect_to(root_path)
      expect(response.body).not_to include(org.name)
    end

    it "renders successful response" do
      sign_in_as(owner)
      get dashboard_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(org.name)
    end
  end
end
