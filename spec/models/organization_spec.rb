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
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { is_expected.to have_many(:seasons) }

  context "validation" do
    it { is_expected.to validate_presence_of(:code) }
  end
end
