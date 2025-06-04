# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  first_name              :string
#  last_name               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_organization_id :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:player_matches) }

  context "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
