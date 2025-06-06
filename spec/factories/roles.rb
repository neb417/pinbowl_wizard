# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
FactoryBot.define do
  factory :role do
    factory :admin_role do
      name { 'admin' }
    end

    factory :owner_role do
      name { 'owner' }
    end

    factory :account_role do
      name { 'account' }
    end
  end
end
