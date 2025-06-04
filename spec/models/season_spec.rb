# == Schema Information
#
# Table name: seasons
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
# Indexes
#
#  index_seasons_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

require 'rails_helper'

RSpec.describe Season, type: :model do
  it { is_expected.to have_many(:rounds) }
  it { is_expected.to belong_to(:organization) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
