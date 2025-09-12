require 'rails_helper'

RSpec.describe "seasons/new", type: :view do
  let(:organization) { create(:organization) }
  let(:user) { create(:owner_user, current_organization: organization) }

  before(:each) do
    sign_in_as(user)
    assign(:season, Season.new(
      title: "MyString",
      organization: organization
    ))
  end

  it "renders new season form" do
    render

    assert_select "form[action=?][method=?]", seasons_path, "post" do
      assert_select "input[name=?]", "season[title]"
    end
  end
end
