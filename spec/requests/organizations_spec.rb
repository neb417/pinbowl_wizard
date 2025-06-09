require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  let!(:user) { create(:user) }

  context "actions not requiring authorization" do
    before(:each) do
      sign_in_as(user)
    end

    describe "GET /new" do
      it "renders successful response" do
        get new_organization_path
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe "POST /create" do
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
    let(:organization) { create(:organization) }
    let!(:admin_user) { create(:admin_user) }
    let!(:owner_user) { create(:owner_user, organization: organization) }

    describe "GET /index" do
      it "renders successful response" do
        sign_in_as(admin_user)
        get organizations_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it "redirects to root path when unauthorized" do
        sign_in_as(create(:user))
        get organizations_path

        expect(response).to be_a_redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /edit" do
      it "renders successful response for admin" do
        sign_in_as(admin_user)
        get edit_organization_path(organization)
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end

      it "renders successful response for owner" do
        sign_in_as(owner_user)
        get edit_organization_path(organization)
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end

      it "redirects to root path when unauthorized" do
        sign_in_as(user)
        get edit_organization_path(organization)

        expect(response).to be_a_redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PATCH /update" do
      it "renders successful response for admin" do
        sign_in_as(admin_user)
        patch organization_path(organization), params: { organization: { name: "New Org Name" } }
        expect(response).to be_a_redirect
        expect(response).to redirect_to(organization_path(organization))
      end

      it "renders successful response for owner" do
        sign_in_as(owner_user)
        patch organization_path(organization), params: { organization: { name: "New Org Name" } }
        expect(response).to be_a_redirect
        expect(response).to redirect_to(organization_path(organization))
      end

      it "redirects to root path when unauthorized" do
        sign_in_as(user)
        patch organization_path(organization), params: { organization: { name: "New Org Name" } }

        expect(response).to be_a_redirect
        expect(response).to redirect_to(root_path)
      end

      it "renders edit on error" do
        sign_in_as(owner_user)
        patch organization_path(organization), params: { organization: { name: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end

    describe "DELETE /organization" do
      it "removes organization for admin" do
        sign_in_as(admin_user)

        expect {
          delete organization_path(organization)
        }.to change(Organization, :count).by(-1)
      end

      it "removes organization for owner" do
        sign_in_as(owner_user)

        expect {
        delete organization_path(organization)
        }.to change(Organization, :count).by(-1)
      end

      it "renders successful response for admin" do
        sign_in_as(admin_user)
        delete organization_path(organization)
        expect(response).to be_a_redirect
        expect(response).to redirect_to(organizations_path)
      end

      it "renders successful response for owner" do
        sign_in_as(owner_user)
        delete organization_path(organization)
        expect(response).to be_a_redirect
        expect(response).to redirect_to(organizations_path)
      end

      it "redirects to root path when unauthorized" do
        sign_in_as(user)
        delete organization_path(organization)

        expect(response).to be_a_redirect
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
