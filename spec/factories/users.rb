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

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password_digest { Faker::Internet.password }


    factory :admin_user do
      after(:create) do |user, _evaluator|
        admin_role = create(:admin_role)

        user.add_role(admin_role.name)
      end
    end

    factory :account_user do
      transient do
        organization { create(:organization) }
      end

      after(:create) do |user, evaluator|
        account_role = create(:account_role)

        user.add_role(account_role.name, evaluator.organization)
      end
    end

    factory :owner_user do
      transient do
        organization { create(:organization) }
      end

      after(:create) do |user, evaluator|
        account_role = create(:account_role)
        owner_role = create(:owner_role)

        user.add_role(account_role.name, evaluator.organization)
        user.add_role(owner_role.name, evaluator.organization)
      end
    end
  end
end
