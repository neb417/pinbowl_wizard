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

RSpec.describe "/machines", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Machine. As you add validations to Machine, be sure to
  # adjust the attributes here as well.
  let!(:user) { create(:user) }
  let(:valid_attributes) { valid_machine_attributes }
  let(:invalid_attributes) { invalid_machine_attributes }

  before(:each) do
    sign_in_as(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      Machine.create! valid_attributes
      get machines_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      machine = Machine.create! valid_attributes
      get machine_url(machine)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_machine_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      machine = Machine.create! valid_attributes
      get edit_machine_url(machine)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Machine" do
        expect {
          post machines_url, params: { machine: valid_attributes }
        }.to change(Machine, :count).by(1)
      end

      it "redirects to the created machine" do
        post machines_url, params: { machine: valid_attributes }
        expect(response).to redirect_to(machine_url(Machine.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Machine" do
        expect {
          post machines_url, params: { machine: invalid_attributes }
        }.to change(Machine, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post machines_url, params: { machine: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { edit_machine_attributes }

      it "updates the requested machine" do
        machine = Machine.create! valid_attributes
        expect(machine.name).to_not eq(new_attributes[:name])

        patch machine_url(machine), params: { machine: new_attributes }

        machine.reload
        expect(machine.name).to eq(new_attributes[:name])
      end

      it "redirects to the machine" do
        machine = Machine.create! valid_attributes
        patch machine_url(machine), params: { machine: new_attributes }
        machine.reload
        expect(response).to redirect_to(machine_url(machine))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        machine = Machine.create! valid_attributes
        patch machine_url(machine), params: { machine: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested machine" do
      machine = Machine.create! valid_attributes
      expect {
        delete machine_url(machine)
      }.to change(Machine, :count).by(-1)
    end

    it "redirects to the machines list" do
      machine = Machine.create! valid_attributes
      delete machine_url(machine)
      expect(response).to redirect_to(machines_url)
    end
  end
end
