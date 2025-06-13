require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  let!(:user) { create(:user) }

  describe "GET /passwords/new" do
    it "response is successful" do
      get new_password_path
      expect(response).to be_successful
    end

    it "renders new form" do
      get new_password_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /passwords" do
    it "response is successful" do
      post passwords_path, params: { email_address: user.email_address }
      expect(response).to be_a_redirect
    end

    it "renders new form" do
      post passwords_path, params: { email_address: user.email_address }
      expect(response).to redirect_to(new_session_path)
    end

    it "enqueues a password reset email" do
      expect {
        post passwords_path, params: { email_address: user.email_address }
      }.to have_enqueued_mail(PasswordsMailer, :reset).with(user)
    end

    it "does not enqueue a password reset email" do
      expect {
        post passwords_path, params: { email_address: "invalid@example.com" }
      }.not_to have_enqueued_mail(PasswordsMailer, :reset).with(user)
    end
  end

  describe "GET /passwords/:token/edit" do
    before(:each) do
      allow_any_instance_of(User).to receive(:generate_token_for).and_return("token")
      allow(User).to receive(:find_by_password_reset_token!).and_return(user)
    end

    it "responds successfully" do
      get edit_password_path(token: user.password_reset_token)
      expect(response).to be_successful
    end

    it "renders the new form" do
      get edit_password_path(token: user.password_reset_token)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /passwords/:token" do
    context "with valid passwords" do
      it "updates the password and redirects" do
        allow_any_instance_of(User).to receive(:generate_token_for).and_return("token")
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)

        patch password_path(token: user.password_reset_token), params: { password: "newpass", password_confirmation: "newpass" }
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(response.body).to include("Password has been reset.")
      end
    end

    context "with mismatched passwords" do
      it "redirects back with an alert" do
        allow_any_instance_of(User).to receive(:generate_token_for).and_return("token")
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)

        patch password_path(token: user.password_reset_token), params: { password: "newpass", password_confirmation: "wrong" }
        expect(response).to redirect_to(edit_password_path(token: user.password_reset_token))
        follow_redirect!
        expect(response.body).to include("Passwords did not match.")
      end
    end

    context "with invalid token" do
      it "redirects back with an alert" do
        patch password_path(token: "invalid_token"), params: { password: "newpass", password_confirmation: "newpass" }
        expect(response).to redirect_to(new_password_path)
        follow_redirect!
        expect(response.body).to include("Password reset link is invalid or has expired.")
      end
    end
  end
end
