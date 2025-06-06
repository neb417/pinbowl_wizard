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
end
