require 'rails_helper'

RSpec.describe HomePolicy, type: :policy do
  let(:org) { create(:organization) }
  let(:account_user) { create(:account_user, organization: org, current_organization: org) }
  let(:owner_user) { create(:owner_user, organization: org, current_organization: org) }
  let(:user) { create(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows user that is signed in' do
      allow(Current).to receive_message_chain(:session, :user_id).and_return(account_user.id)
      expect(subject).to permit(account_user)
    end

    it "rejects when not signed in" do
      allow(Current).to receive_message_chain(:session, :user_id).and_return(nil)
      expect(subject).to_not permit(account_user)
    end
  end
end
