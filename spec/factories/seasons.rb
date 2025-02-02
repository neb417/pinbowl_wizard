# == Schema Information
#
# Table name: seasons
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :season do
    title { "MyString" }
  end
end
