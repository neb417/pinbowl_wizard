require 'rails_helper'

RSpec.describe HomePolicy, type: :policy do
  let(:org) { create(:organization) }
  let(:account_user) { create(:account_user, organization: org, current_organization: org) }
  let(:owner_user) { create(:owner_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  subject { described_class }

  permissions :dashboard? do
    it { expect(subject).to permit(account_user) }
    it { expect(subject).to permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end
end
