require 'rails_helper'

RSpec.describe "Memberships", type: :request do
  let(:user) { create(:user) }

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
end
