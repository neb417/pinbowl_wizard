require 'rails_helper'

RSpec.describe "machines/edit", type: :view do
  let(:organization) { FactoryBot.create(:organization)  }
  let(:machine) {
    Machine.create!(
      name: "MyString",
      organization: organization
    )
  }

  before(:each) do
    assign(:machine, machine)
  end

  it "renders the edit machine form" do
    render

    assert_select "form[action=?][method=?]", machine_path(machine), "post" do
      assert_select "input[name=?]", "machine[name]"
    end
  end
end
