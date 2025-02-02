# == Schema Information
#
# Table name: machines
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Machine, type: :model do
  it { is_expected.to have_many(:matches) }
end
