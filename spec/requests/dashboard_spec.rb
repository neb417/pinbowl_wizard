require 'rails_helper'

RSpec.describe "/dashboard", type: :request do
  let(:org) { create(:organization) }
  let(:owner) { create(:owner_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  describe "GET/index" do
    it "renders unauthorized response" do
      sign_in_as(user)
      get dashboard_path
      expect(response).to redirect_to(root_path)
    end

    it "renders successful response" do
      sign_in_as(owner)
      get dashboard_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end
end
