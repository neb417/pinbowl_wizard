# == Schema Information
#
# Table name: memberships
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_memberships_on_organization_id  (organization_id)
#  index_memberships_on_user_id          (user_id)
#
require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:organization) }
end
