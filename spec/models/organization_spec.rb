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

  context "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
  end

  context "instance methods" do
    let(:org_1) { create(:organization) }
    let(:org_2) { create(:organization) }

    context "roles" do
      let(:org_1_admin) { create(:admin_user, organization: org_1, current_organization: org_1) }
      let(:org_1_account) { create(:account_user, organization: org_1, current_organization: org_1) }
      let(:org_2_admin) { create(:admin_user, organization: org_2, current_organization: org_2) }
      let(:org_2_account) { create(:account_user, organization: org_2, current_organization: org_2) }

      describe "#accounts" do
        it { expect(org_1.accounts).to match_array([ org_1_admin, org_1_account ]) }
        it { expect(org_1.accounts).to_not include(org_2_admin) }
        it { expect(org_1.accounts).to_not include(org_2_account) }
        it { expect(org_2.accounts).to match_array([ org_2_admin, org_2_account ]) }
        it { expect(org_2.accounts).to_not include(org_1_admin) }
        it { expect(org_2.accounts).to_not include(org_1_account) }
      end

      describe "#admins" do
        it { expect(org_1.admins).to match_array([ org_1_admin ]) }
        it { expect(org_2.admins).to match_array([ org_2_admin ]) }
        it { expect(org_1.admins).to_not include(org_1_account) }
        it { expect(org_1.admins).to_not include(org_2_admin) }
        it { expect(org_1.admins).to_not include(org_2_account) }
        it { expect(org_2.admins).to_not include(org_2_account) }
        it { expect(org_2.admins).to_not include(org_1_admin) }
        it { expect(org_2.admins).to_not include(org_1_account) }
      end
    end
  end
end
