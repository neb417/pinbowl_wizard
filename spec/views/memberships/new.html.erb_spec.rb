require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new)
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do
      assert_select "input[name=?]", "membership[organization_code]"
    end
  end
end
