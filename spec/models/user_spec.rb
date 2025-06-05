# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email_address           :string           not null
#  first_name              :string
#  last_name               :string
#  password_digest         :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_organization_id :integer
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:player_matches) }

  context "validations" do
    it { is_expected.to validate_presence_of(:email_address) }
  end
end
