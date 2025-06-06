require 'rails_helper'

RSpec.describe "rounds/index", type: :view do
  let(:season) { create(:season) }
  before(:each) do
    assign(:rounds, create_list(:round, 2, season: season))
  end

  it "renders a list of rounds" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Season".to_s), count: 2
  end
end
