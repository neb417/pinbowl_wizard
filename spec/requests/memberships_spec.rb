require 'rails_helper'

RSpec.describe "Memberships", type: :request do
  let(:user) { create(:user) }
  let(:org) { create(:organization) }

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
        post memberships_path, params: { membership: valid_membership_attributes(org.code) }
      }.to change(Membership, :count).by(1)
    end

    it "renders successful response" do
      post memberships_path, params: { membership: valid_membership_attributes(org.code) }
      expect(response).to redirect_to(dashboard_path)
    end

    it "adds an account for user" do
      expect(user.roles).to eq([])
      post memberships_path, params: { membership: valid_membership_attributes(org.code) }
      expect(org.accounts).to eq([ user ])
    end

    it "does not create a membership on unsuccessful POST" do
      expect {
      post memberships_path, params: { membership: invalid_membership_attributes }
      }.to_not change(Membership, :count)
    end

    it "renders new with unprocessable response" do
      post memberships_path, params: { membership: invalid_membership_attributes }
      expect(response).to render_template(:new)
    end
  end
end
