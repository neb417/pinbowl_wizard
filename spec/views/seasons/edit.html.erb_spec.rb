require 'rails_helper'

RSpec.describe "seasons/edit", type: :view do
  let(:organization) { create(:organization) }
  let(:season) { create(:season, organization: organization) }
  let(:user) { create(:owner_user, current_organization: organization) }

  before(:each) do
    sign_in_as(user)
    assign(:season, season)
  end

  it "renders the edit season form" do
    render

    assert_select "form[action=?][method=?]", season_path(season), "post" do
      assert_select "input[name=?]", "season[title]"
    end
  end
end
