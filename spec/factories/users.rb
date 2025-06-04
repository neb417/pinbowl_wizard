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

FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
  end
end
