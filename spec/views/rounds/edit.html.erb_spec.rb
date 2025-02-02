require 'rails_helper'

RSpec.describe "rounds/edit", type: :view do
  let(:round) {
    Round.create!(
      season: nil
    )
  }

  before(:each) do
    assign(:round, round)
  end

  it "renders the edit round form" do
    render

    assert_select "form[action=?][method=?]", round_path(round), "post" do
      assert_select "input[name=?]", "round[season_id]"
    end
  end
end
