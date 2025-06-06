require "rails_helper"

RSpec.describe "/registrations", type: :request do
  describe "GET /new" do
    it "renders a successful response" do
      get new_registration_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "adds a user" do
      expect {
        post registrations_path, params: { user: valid_registration_params }
      }.to change(User, :count).by(1)
    end

    it "does not add a user" do
      post registrations_path, params: { user: invalid_registration_params }
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end
end
