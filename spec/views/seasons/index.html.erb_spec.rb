require 'rails_helper'

RSpec.describe "seasons/index", type: :view do
  before(:each) do
    assign(:seasons, create_list(:season, 2))
  end

  it "renders a list of seasons" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
  end
end
