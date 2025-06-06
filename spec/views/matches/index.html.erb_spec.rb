require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  let(:match_1) { create(:match) }
  let(:match_2) { create(:match) }
  let(:matches) { [ match_1, match_2 ] }

  before(:each) do
    assign(:matches, matches)
  end

  it "renders a list of matches" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Round".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Machine".to_s), count: 2
  end
end
