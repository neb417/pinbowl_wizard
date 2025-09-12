# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_organizations_on_code  (code) UNIQUE
#  index_organizations_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { is_expected.to have_many(:seasons) }
  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:machines) }
  it { is_expected.to have_many(:users).through(:memberships) }

  context "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }

    describe "valid organization codes" do
      it { expect(Organization.new(name: 'Test', code: "").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "1").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "12").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "123").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "1234").valid?).to be_truthy }
      it { expect(Organization.new(name: 'Test', code: "1_2_4").valid?).to be_truthy }
      it { expect(Organization.new(name: 'Test', code: "1-2-4").valid?).to be_truthy }
      it { expect(Organization.new(name: 'Test', code: "1*2*4").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "(1234)").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "%1234").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "#1234").valid?).to be_falsey }
      it { expect(Organization.new(name: 'Test', code: "^1234").valid?).to be_falsey }
    end
  end

  context "instance methods" do
    let(:org_1) { create(:organization) }
    let(:org_2) { create(:organization) }

    context "roles" do
      let(:org_1_owner) { create(:owner_user, organization: org_1, current_organization: org_1) }
      let(:org_1_account) { create(:account_user, organization: org_1, current_organization: org_1) }
      let(:org_2_owner) { create(:owner_user, organization: org_2, current_organization: org_2) }
      let(:org_2_account) { create(:account_user, organization: org_2, current_organization: org_2) }

      describe "#accounts" do
        it { expect(org_1.accounts).to match_array([ org_1_owner, org_1_account ]) }
        it { expect(org_1.accounts).to_not include(org_2_owner) }
        it { expect(org_1.accounts).to_not include(org_2_account) }
        it { expect(org_2.accounts).to match_array([ org_2_owner, org_2_account ]) }
        it { expect(org_2.accounts).to_not include(org_1_owner) }
        it { expect(org_2.accounts).to_not include(org_1_account) }
      end

      describe "#owners" do
        it { expect(org_1.owners).to match_array([ org_1_owner ]) }
        it { expect(org_2.owners).to match_array([ org_2_owner ]) }
        it { expect(org_1.owners).to_not include(org_1_account) }
        it { expect(org_1.owners).to_not include(org_2_owner) }
        it { expect(org_1.owners).to_not include(org_2_account) }
        it { expect(org_2.owners).to_not include(org_2_account) }
        it { expect(org_2.owners).to_not include(org_1_owner) }
        it { expect(org_2.owners).to_not include(org_1_account) }
      end
    end
  end
end
