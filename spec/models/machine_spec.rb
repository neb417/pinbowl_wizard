# == Schema Information
#
# Table name: machines
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_machines_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

require 'rails_helper'

RSpec.describe Machine, type: :model do
  it { is_expected.to have_many(:matches) }
  it { is_expected.to belong_to(:organization) }

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
