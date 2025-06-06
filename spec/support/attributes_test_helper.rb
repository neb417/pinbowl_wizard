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
end
