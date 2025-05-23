require 'rails_helper'

RSpec.describe "rounds/new", type: :view do
  before(:each) do
    assign(:round, Round.new(
      season: nil
    ))
  end

  it "renders new round form" do
    render

    assert_select "form[action=?][method=?]", rounds_path, "post" do
      assert_select "input[name=?]", "round[season_id]"
    end
  end
end
