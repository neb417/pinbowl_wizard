require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  let!(:match) { build(:match) }

  before(:each) do
    assign(:match, match)
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do
      assert_select "input[name=?]", "match[round_id]"

      assert_select "input[name=?]", "match[machine_id]"
    end
  end
end
