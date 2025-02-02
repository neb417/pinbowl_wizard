require 'rails_helper'

RSpec.describe "machines/new", type: :view do
  before(:each) do
    assign(:machine, Machine.new(
      name: "MyString"
    ))
  end

  it "renders new machine form" do
    render

    assert_select "form[action=?][method=?]", machines_path, "post" do
      assert_select "input[name=?]", "machine[name]"
    end
  end
end
