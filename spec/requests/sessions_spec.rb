require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /session/new" do
    it "login path response is successful" do
      get new_session_path
      expect(response).to be_successful
    end

    it "redirects to sign in page when not logged in" do
      get root_path
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "POST /create" do
    let(:user) { create(:user) }

    it "response is successful" do
      allow_any_instance_of(User).to receive(:authenticate_password).and_return(user)
      post session_path, params: { email_address: user.email_address, password: user.password_digest }
      expect(response).to be_a_redirect
    end

    it "redirects to root path on success" do
      allow_any_instance_of(User).to receive(:authenticate_password).and_return(user)
      post session_path, params: { email_address: user.email_address, password: user.password_digest }
      expect(response).to redirect_to(root_path)
    end

    it "response a redirect on failed submission" do
      post session_path, params: { email_address: "", password: "" }
      expect(response).to be_a_redirect
    end

    it "redirects to new session path on failure" do
      post session_path, params: { email_address: "", password: "" }
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "DELETE /session" do
    let(:user) { create(:user) }

    it "response is a redirect" do
      sign_in_as(user)
      delete session_path

      expect(response).to be_a_redirect
    end

    it "redirects to new session path" do
      sign_in_as(user)
      delete session_path

      expect(response).to redirect_to(new_session_path)
    end
  end
end
