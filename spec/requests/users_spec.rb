require "rails_helper"

RSpec.describe "/users", type: :request do
  let(:organization) { create(:organization) }
  let!(:user) { create(:user, current_organization: organization) }
  let(:invalid_attributes) { invalid_user_attributes }
  let!(:invalid_user) { build(:user, invalid_attributes) }

  describe "GET /index" do
    it "renders a successful response" do
      sign_in_as(user)
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sign_in_as(user)
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in_as(user)
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sign_in_as(user)
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before(:each) { sign_in_as(user) }

    context "with valid parameters" do
      let!(:create_attributes) { valid_user_attributes }

      it "creates a new User" do
        expect {
          post users_url, params: { user: create_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_url, params: { user: create_attributes }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    before(:each) { sign_in_as(user) }

    context "with valid parameters" do
      let(:new_attributes) { edit_user_attributes }

      it "updates the requested user" do
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.first_name).to eq(new_attributes[:first_name])
        expect(user.last_name).to eq(new_attributes[:last_name])
        expect(user.email_address).to eq(new_attributes[:email_address])
      end

      it "redirects to the user" do
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(user_url(user))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch user_url(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:other_user) { create(:user) }

    before :each do
      sign_in_as(other_user)
    end

    it "destroys the requested user" do
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
