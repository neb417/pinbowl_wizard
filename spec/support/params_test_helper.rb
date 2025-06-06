module ParamsTestHelper
  def valid_machine_params
    { name: Faker::FunnyName.name }
  end

  def invalid_machine_params
    { name: "" }
  end

  def edit_machine_attributes
    { name: Faker::FunnyName.name }
  end
end
