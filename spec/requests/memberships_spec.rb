require 'rails_helper'

RSpec.describe "Memberships", type: :request do
  let(:user) { create(:user) }
  let(:org) { create(:organization) }
  let(:valid_membership_params) { { organization_code: org.code } }
  let(:invalid_membership_params) { { organization_code: "" } }

  before(:each) do
    sign_in_as(user)
  end

  describe "GET /new" do
    it "renders successful response" do
      get new_membership_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do
    it "creates a membership on successful POST" do
      expect {
      post memberships_path, params: { membership: valid_membership_params }
      }.to change(Membership, :count).by(1)
    end

    it "renders successful response" do
      post memberships_path, params: { membership: valid_membership_params }
      expect(response).to redirect_to(dashboard_path)
    end

    it "adds an account for user" do
      expect(user.roles).to eq([])
      post memberships_path, params: { membership: valid_membership_params }
      expect(org.accounts).to eq([ user ])
    end

    it "does not create a membership on unsuccessful POST" do
      expect {
      post memberships_path, params: { membership: invalid_membership_params }
      }.to_not change(Membership, :count)
    end

    it "renders new with unprocessable response" do
      post memberships_path, params: { membership: invalid_membership_params }
      expect(response).to render_template(:new)
    end
  end
end
