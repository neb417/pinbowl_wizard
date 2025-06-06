require "rails_helper"

RSpec.describe OrganizationCreator, type: :service do
  let(:user) { create(:user) }
  let(:valid_org_params) { { name: "Test", code: "test_org" } }
  let(:invalid_org_params) { { name: "", code: "test*org" } }

  it { expect { OrganizationCreator.call(user: user, org_params: valid_org_params).to change(Organization, :count).by(1) } }
  it { expect { OrganizationCreator.call(user: user, org_params: invalid_org_params).to_not change(Organization, :count) } }

  describe "adds current organization and roles to user on successful creation" do
    before :each do
      OrganizationCreator.call(user: user, org_params: valid_org_params)
    end

    it { expect(user.current_organization).to eq(Organization.last) }
    it { expect(user.has_role?(:account, user.current_organization)).to be_truthy }
    it { expect(user.has_role?(:owner, user.current_organization)).to be_truthy }
  end

  describe "does not add current organization or roles to user on unsuccessful creation" do
    before :each do
      OrganizationCreator.call(user: user, org_params: invalid_org_params)
    end

    it { expect(user.current_organization).to eq(nil) }
    it { expect(user.roles).to eq([]) }
  end
end
