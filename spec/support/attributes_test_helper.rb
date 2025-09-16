module AttributesTestHelper
  def valid_machine_attributes
    { name: Faker::FunnyName.name,  organization_id: FactoryBot.create(:organization).id }
  end

  def invalid_machine_attributes
    { name: "", organization_id: FactoryBot.create(:organization).id }
  end

  def edit_machine_attributes
    { name: Faker::FunnyName.name }
  end

  def valid_match_attributes
    { flight_id: create(:flight).id, machine_id: create(:machine).id }
  end

  def invalid_match_attributes
    { flight_id: nil, machine_id: nil }
  end

  def edit_match_attributes
    { flight_id: create(:flight).id, machine_id: create(:machine).id }
  end

  def valid_membership_attributes(org_code)
    { organization_code: org_code }
  end

  def invalid_membership_attributes
    { organization_code: "" }
  end

  def valid_organization_attributes
    { name: Faker::Company.name, code: "12345" }
  end

  def invalid_organization_attributes
    { name: nil, code: nil }
  end

  def valid_registration_params
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email_address: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password'
    }
  end

  def invalid_registration_params
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email_address: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'does not match'
    }
  end

  def valid_round_attributes
    { season_id: create(:season).id, number: Faker::Number.number(digits: 1) }
  end

  def invalid_round_attributes
    { season_id: nil, number: nil }
  end

  def edit_round_attributes
    { season_id: create(:season).id, number: Faker::Number.number(digits: 1) }
  end

  def valid_season_attributes
    { title: Faker::FunnyName.name, organization_id: create(:organization).id }
  end

  def invalid_season_attributes
    { title: nil, organization_id: nil }
  end

  def edit_season_attributes
    { organization_id: create(:organization).id, title: Faker::FunnyName.name }
  end

  def valid_user_attributes
    password = Faker::Internet.password
    { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email_address: Faker::Internet.email, password: password, password_confirmation: password }
  end

  def invalid_user_attributes
    { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email_address: "" }
  end

  def edit_user_attributes
    { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email_address: Faker::Internet.email }
  end
end
