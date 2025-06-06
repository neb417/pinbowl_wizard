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
