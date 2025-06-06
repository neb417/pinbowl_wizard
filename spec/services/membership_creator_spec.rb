require "rails_helper"

RSpec.describe MembershipCreator, type: :service do
  subject { described_class.call(user: user, organization: org) }
  let(:user) { create(:user) }
  let(:org) { create(:organization) }

  it { expect { subject }.to change(Membership, :count).by(1) }
  it { expect { subject }.to change(user.roles, :count).by(1) }
  it { expect { subject }.to change(user, :current_organization).from(nil).to(org) }

  it "adds account role to user" do
    expect(org.accounts).to eq([])
    subject
    expect(org.accounts).to eq([ user ])
  end
end
