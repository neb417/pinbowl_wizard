# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  first_name              :string
#  last_name               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_organization_id :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:player_matches) }
end
