require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  let(:user) { create(:user) }

  before(:each) do
    sign_in_as(user)
  end

  context "actions not requiring authorization" do
    describe "GET /new" do
      it "renders successful response" do
        get new_organization_path
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe "POST /create" do
      let(:valid_params) { { name: Faker::Company.name, code: "12345" } }
      let(:invalid_params) { { name: "", code: "" } }

      it "creates a new organization on successful POST" do
        expect {
          post organizations_path, params: { organization: valid_organization_attributes }
        }.to change(Organization, :count).by(1)
      end

      it "redirects on successful POST" do
        post organizations_path, params: { organization: valid_organization_attributes }
        expect(response).to redirect_to(dashboard_path)
      end

      it "does not create a new organization on unsuccessful POST" do
        expect {
          post organizations_path, params: { organization: invalid_organization_attributes }
        }.to_not change(Organization, :count)
      end

      it "renders new on fail to POST" do
        post organizations_path, params: { organization: invalid_organization_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  context "actions requiring authorization" do
    describe "GET /index" do
      it "renders successful response" do
        get organizations_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end
  end
end
