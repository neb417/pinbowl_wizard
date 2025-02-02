# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Season, type: :model do
  it { is_expected.to have_many(:rounds) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
