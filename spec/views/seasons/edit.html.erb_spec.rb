require 'rails_helper'

RSpec.describe "seasons/edit", type: :view do
  let(:season) { create(:season) }

  before(:each) do
    assign(:season, season)
  end

  it "renders the edit season form" do
    render

    assert_select "form[action=?][method=?]", season_path(season), "post" do
      assert_select "input[name=?]", "season[title]"
    end
  end
end
