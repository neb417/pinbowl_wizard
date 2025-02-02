require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  let(:match_1) { create(:match) }
  let(:match_2) { create(:match) }
  let(:matches) { [ match_1, match_2 ] }

  before(:each) do
    assign(:matches, matches)
  end

  xit "renders a list of matches" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
