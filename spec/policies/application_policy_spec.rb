require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  let(:org) { create(:organization) }
  let(:account_user) { create(:account_user, organization: org, current_organization: org) }
  let(:owner_user) { create(:owner_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  subject { described_class }

  permissions :index? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :show? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :create? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :new? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :update? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :edit? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  permissions :destroy? do
    it { expect(subject).to_not permit(account_user) }
    it { expect(subject).to_not permit(owner_user) }
    it { expect(subject).not_to permit(user) }
  end

  describe ApplicationPolicy::Scope do
    let(:scope) { double('scope', all: :all_records) }

    it 'raises error if user is nil' do
      expect { described_class.new(nil, scope) }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'returns all records by default' do
      resolved = described_class.new(user, scope).resolve
      expect(resolved).to eq(:all_records)
    end
  end
end
