require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/rounds", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Round. As you add validations to Round, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Round.create! valid_attributes
      get rounds_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      round = Round.create! valid_attributes
      get round_url(round)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_round_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      round = Round.create! valid_attributes
      get edit_round_url(round)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Round" do
        expect {
          post rounds_url, params: { round: valid_attributes }
        }.to change(Round, :count).by(1)
      end

      it "redirects to the created round" do
        post rounds_url, params: { round: valid_attributes }
        expect(response).to redirect_to(round_url(Round.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Round" do
        expect {
          post rounds_url, params: { round: invalid_attributes }
        }.to change(Round, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post rounds_url, params: { round: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested round" do
        round = Round.create! valid_attributes
        patch round_url(round), params: { round: new_attributes }
        round.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the round" do
        round = Round.create! valid_attributes
        patch round_url(round), params: { round: new_attributes }
        round.reload
        expect(response).to redirect_to(round_url(round))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        round = Round.create! valid_attributes
        patch round_url(round), params: { round: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested round" do
      round = Round.create! valid_attributes
      expect {
        delete round_url(round)
      }.to change(Round, :count).by(-1)
    end

    it "redirects to the rounds list" do
      round = Round.create! valid_attributes
      delete round_url(round)
      expect(response).to redirect_to(rounds_url)
    end
  end
end
