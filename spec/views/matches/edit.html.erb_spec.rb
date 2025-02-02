require 'rails_helper'

RSpec.describe "matches/edit", type: :view do
  let(:match) { create(:match) }

  before(:each) do
    assign(:match, match)
  end

  it "renders the edit match form" do
    render

    assert_select "form[action=?][method=?]", match_path(match), "post" do
      assert_select "input[name=?]", "match[round_id]"

      assert_select "input[name=?]", "match[machine_id]"
    end
  end
end
