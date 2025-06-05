require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:player_matches) }

  context "validations" do
    it { is_expected.to validate_presence_of(:email_address) }
  end
end
