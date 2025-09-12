# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require_relative '../app/services/membership_creator'

org1 = Organization.create!(name: 'Pinbowl', code: 'pinbowl')
org2 = Organization.create!(name: 'Bowlpin', code: 'bowlpin')

owner1 = User.create!(first_name: 'Owner1', last_name: 'User1', email_address: 'owner1@test.com', password: 'password')
owner2 = User.create!(first_name: 'Owner2', last_name: 'User2', email_address: 'owner2@test.com', password: 'password')

owner1.add_role(:account, org1)
owner1.add_role(:owner, org1)
owner1.update!(current_organization: org1)

owner2.add_role(:account, org2)
owner2.add_role(:owner, org2)
owner2.update!(current_organization: org2)

user_index = 1
10.times do
  user = User.create!(first_name: "Test#{user_index}", last_name: "User#{user_index}", email_address: "user#{user_index}@test.com", password: 'password')
  org = user_index % 2 == 0 ? org2 : org1
  MembershipCreator.call(user: user, organization: org)
  user_index += 1
end

User.create!(first_name: 'Unassigned', last_name: 'Test-User', email_address: 'unassigned@test.com', password: 'password')

index1 = 1
3.times do
  Machine.create!(name:  "#{org1.name} machine #{index1}", organization: org1)
  index1 += 1
end

index2 = 1
3.times do
  Machine.create!(name:  "#{org2.name} machine #{index2}", organization: org2)
  index2 += 1
end

Season.create!(title: "#{org1.name} Season", organization: org1)
Season.create!(title: "#{org2.name} Season", organization: org2)
