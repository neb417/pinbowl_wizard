module AttributesTestHelper
  def valid_machine_attributes
    { name: Faker::FunnyName.name }
  end

  def invalid_machine_attributes
    { name: "" }
  end

  def edit_machine_attributes
    { name: Faker::FunnyName.name }
  end

  def valid_match_attributes
    { round_id: create(:round).id, machine_id: create(:machine).id }
  end

  def invalid_match_attributes
    { round_id: nil, machine_id: nil }
  end

  def edit_match_attributes
    { round_id: create(:round).id, machine_id: create(:machine).id }
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
end
